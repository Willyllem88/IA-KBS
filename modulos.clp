(defmodule MAIN (export ?ALL))

;módulo MAIN, punto de inicio
(defrule MAIN::inicio
=>
(printout t "Sea usted bienvenido al nuestro sistema de recomendacions de rutas por el museo." crlf)
(printout t"Para poder hacerle una visita que se adapte a usted lo mejor posble, responda a las siguentes preguntas." crlf)
(focus recopilacion)
)

;módulo para recopilar datos del usuario
(defmodule recopilacion (import MAIN ?ALL)(export ?ALL))

; Método para preguntar al usuario y comprobar que la respuesta sea un número entero
(deffunction recopilacion::pregunta-comprobar-int(?mensaje)
    (printout t ?mensaje crlf)
    (bind ?respuesta (read))
    (while (not (integerp ?respuesta)) do
        (printout t "  ERROR: Por favor, introduce un número entero." crlf)
        (bind ?respuesta (read))
    )
    (return ?respuesta)
)

; Método para preguntar al usuario y comprobar que la respuesta sea 'si' o 'no'
(deffunction recopilacion::pregunta-comprobar-boolean(?mensaje)
    (printout t ?mensaje crlf)
    (bind ?respuesta (read))
    (while (not (or (eq ?respuesta si) (eq ?respuesta no))) do
        (printout t "  ERROR: Has introducido: '" ?respuesta "''. Por favor, introduce 'si' o 'no'." crlf)
        (bind ?respuesta (read))
    )
    (return ?respuesta)
)

; TODO: deixar d'utilitzar aquest mètode i utilitzar el mètode pregunta-comprobar
(deffunction recopilacion::pregunta-datos (?pregunta)
    (format t "%s: " ?pregunta)
    (bind ?respuesta (read))
    ?respuesta
)

; TODO: utilitzar un mètode que recopili tota la informació en un sol mètode defrule recopilacion::preguntar-datos
(defrule recopilacion::preguntar-datos
    "Ronda de preguntas para recopilar datos del usuario"

    =>

    (bind ?personas (pregunta-comprobar-int "¿Cuántas personas sois?"))
    (bind ?niños (if (> ?personas 1) then (pregunta-comprobar-boolean "¿Hay niños en el grupo? (si/no)") else "no"))
    (bind ?dias (pregunta-comprobar-int "¿Cuántos días durará vuestra visita?"))
    (bind ?horas (pregunta-comprobar-int "¿Cuántas horas dedicareis cada día a vuestra visita?"))
    (bind ?museos (pregunta-comprobar-int "¿Cuántos museos habéis visitado en el último año?"))


    ; Preguntar por el estilo preferido
    (bind $?instancias-estilo (find-all-instances ((?inst Estilo)) TRUE))
    (bind $?nombres-estilo (create$))
    (loop-for-count (?i 1 (length$ $?instancias-estilo)) do ; Itera sobre todas las instancias de estilos
        (bind ?instancia (nth$ ?i $?instancias-estilo))
        (if (eq (length$ $?nombres-estilo) 0) then
            (bind $?nombres-estilo (insert$ $?nombres-estilo 1 ?instancia))
            else
            (bind $?nombres-estilo (insert$ $?nombres-estilo (length$ $?nombres-estilo) ?instancia))
        )
    )
    (printout t "Lista de estilos disponibles:" crlf)
    (printout t "0. [No lo sé]" crlf)
    (loop-for-count (?i 1 (length$ $?nombres-estilo)) do
        (printout t ?i ". " (nth$ ?i $?nombres-estilo) crlf)
    )
    (bind ?eleccion (pregunta-comprobar-int "Introduce el número del estilo que prefieras: "))
    (if (and (>= ?eleccion 0) (<= ?eleccion (length$ $?nombres-estilo)))
      then
      (bind ?estilo (nth$ ?eleccion $?nombres-estilo))
      (assert (preferencia-de-estilo ?estilo))  ;;Guardar respuesta
      else
      (printout t "Opción no válida." crlf)
    )

    ; Preguntar por el artista preferido
    (bind $?instancias-artistas (find-all-instances ((?inst Artista)) TRUE))
    (bind $?nombres-artistas (create$))
    (loop-for-count (?i 1 (length$ $?instancias-artistas)) do ; Itera sobre todas las instancias de artistas
        (bind ?instancia (nth$ ?i $?instancias-artistas))
        (if (eq (length$ $?nombres-artistas) 0) then
            (bind $?nombres-artistas (insert$ $?nombres-artistas 1 ?instancia))
            else
            (bind $?nombres-artistas (insert$ $?nombres-artistas (length$ $?nombres-artistas) ?instancia))
        )
    )
    (printout t "Lista de artistas disponibles:" crlf)
    (printout t "0. [No lo sé]" crlf)
    (loop-for-count (?i 1 (length$ $?nombres-artistas)) do
        (printout t ?i ". " (nth$ ?i $?nombres-artistas) crlf)
    )
    (bind ?eleccion (pregunta-comprobar-int "Introduce el número del artista que prefieras: "))
    (if (and (>= ?eleccion 0) (<= ?eleccion (length$ $?nombres-artistas)))
      then
      (bind ?artista (nth$ ?eleccion $?nombres-artistas))
      (assert (preferencia-de-artista ?artista))
      else
      (printout t "Opción no válida." crlf)
    )

    ;DEBUG: mostrar datos recopilados (variables)
    ;(printout t "Datos recopilados (variables):" crlf)
    ;(printout t "  Personas: " ?personas crlf)
    ;(printout t "  Niños: " ?niños crlf)
    ;(printout t "  Días: " ?dias crlf)
    ;(printout t "  Horas: " ?horas crlf)
    ;(printout t "  Museos: " ?museos crlf)
    ;(printout t "  Estilo: " ?estilo crlf)
    ;(printout t "  Artista: " ?artista crlf)

    ;Crear la instancia de Visita
    (make-instance visita1 of Visita
          (nDias ?dias)
          (nHoras/Dia ?horas)
          (nMuseosVisitados ?museos)
          (esFamilia (eq ?niños si))
          (nPersonas ?personas)
     )
    (assert (preferencia-de-estilo ?estilo))
    (assert (preferencia-de-artista ?artista))

    (focus abstraccion)
)

; Modulo de abstracción, se encarga de clasificar la visita según el conocimiento, la duración y el tipo de grupo
(defmodule abstraccion (import MAIN ?ALL)(import recopilacion ?ALL)(export ?ALL))

; Regla de abstracción que clasifica la visita según el conocimiento, la duración y el tipo de grupo
(defrule abstraccion::abstraccion-problema
   ?visita <- (object(is-a Visita) (nDias ?dias)(nHoras/Dia ?horas)(nMuseosVisitados ?museos)(nPersonas ?personas))
   (preferencia-de-estilo ?preferencia-de-estilo)

   =>

    (bind ?coneixement
        (if (<= ?museos 1) then
            "bajo"
        else (if (and (> ?museos 1) (<= ?museos 5)) then
                "mediano"
                else "alto")))

    (bind ?duracion-total (* ?dias ?horas))
    (bind ?duracion
        (if (<= ?duracion-total 5) then
            "corta"
        else "larga"))


	(bind ?tipo-grupo
    	(if (<= ?personas 1) then
            "individual"
    	else (if (and (> ?personas 1) (<= ?personas 5)) then
            "pequeño"
    	else "grande")))

    ;(printout t "Clasificación abstracta de la visita:" crlf)
    ;(printout t "  Conocimiento: " ?coneixement crlf)
    ;(printout t "  Duración de la visita: " ?duracion crlf)
    ;(printout t "  Tipo de grupo: " ?tipo-grupo crlf)
    ;(printout t "  Preferencia estilo: " ?preferencia-de-estilo crlf)

    ;(printout t "DEBUG: Modificant la instància: " ?visita crlf)
    ; Modificar la instancia de Visita
    (send [visita1] put-CONOCIMIENTO ?coneixement)
    (send [visita1] put-DURACIÓN ?duracion)
    (send [visita1] put-TIPOGRUPO ?tipo-grupo)
    (send [visita1] put-ESTILOPREFERIDO ?preferencia-de-estilo) 

    ;; Verificar que los atributos se han modificado de la instancia visita -> QUITAR CUANDO SE REVISE
    ;(printout t "DEBUG: Comprobación de atributos modificados:" crlf)
    (printout t "  CONOCIMIENTO: " (send [visita1] get-CONOCIMIENTO) crlf)
    (printout t "  DURACIÓN: " (send [visita1] get-DURACIÓN) crlf)
    (printout t "  TIPOGRUPO: " (send [visita1] get-TIPOGRUPO) crlf)
    (printout t "  ESTILOPREFERIDO: " (send [visita1] get-ESTILOPREFERIDO) crlf)
    (printout t "  esFamilia: " (send [visita1] get-esFamilia) crlf)
    
    (focus matching)
    (run)

)

; Modulo de matching, se encarga de asignar un grupo al visitante según sus preferencias
(defmodule matching (import MAIN ?ALL)(import abstraccion ?ALL)(export ?ALL))

; Pintar las obras de una ruta
(deffunction matching::pintar-ruta (?ruta)
    (if (instancep ?ruta) then
        (bind ?obras (send ?ruta get-ruta_contiene))
        (printout t "Obras en la ruta:" crlf)
        (foreach ?obra ?obras
            (printout t "  - " ?obra crlf))
    else
        (printout t "Error: El argumento proporcionado no es una instancia válida de Ruta." crlf))
)

; Grupo para visitantes que prefieren el estilo barroco
(defrule matching::grupo-barroco
    ?visita <- (object (is-a Visita) (CONOCIMIENTO ?conocimiento) (ESTILOPREFERIDO ?estilopreferido))
    (test (or (eq ?conocimiento "alto") (eq ?conocimiento "medio")))
    (test (eq ?estilopreferido [Barroco]))

    =>

    (assert (grupo BARROCO))
)

; Grupo para amantes del arte moderno
(defrule matching::grupo-modernista
    ?visita <- (object (is-a Visita) (CONOCIMIENTO ?conocimiento) (ESTILOPREFERIDO ?estilopreferido))
    (test (or (eq ?conocimiento "alto") (eq ?conocimiento "medio")))
    (test (eq ?estilopreferido [ArteModerno]))

    =>

    (assert (grupo MODERNISTA))
)

; Grupo para visitantes que prefieren el Renacimiento
(defrule matching::grupo-renacentista
    ?visita <- (object (is-a Visita) (CONOCIMIENTO ?conocimiento) (ESTILOPREFERIDO ?estilopreferido))
    (test (or (eq ?conocimiento "alto") (eq ?conocimiento "medio")))
    (test (eq ?estilopreferido [Renacimiento]))

    =>

    (assert (grupo RENACENTISTA))
)

; Grupo para expertos en arte
(defrule matching::grupo-experto
    ?visita <- (object (is-a Visita) (CONOCIMIENTO "alto")(ESTILOPREFERIDO ?estilopreferido))
    (test (and (and (not (eq ?estilopreferido [Renacimiento])) (not (eq ?estilopreferido [ArteModerno]))) (not (eq ?estilopreferido [Barroco]))))

    =>

    (assert (grupo EXPERTO))
)

; Grupo para familias con niños
(defrule matching::grupo-ninos
    ?visita <- (object (is-a Visita) (esFamilia TRUE))

    =>

    (assert (grupo NIÑOS))
)

; Grupo general para visitantes con conocimiento bajo o medio
(defrule matching::grupo-general
    ?visita <- (object (is-a Visita) (CONOCIMIENTO ?conocimiento) (esFamilia FALSE))
    (test (not (eq ?conocimiento "alto")))

    =>

    (assert (grupo GENERAL))
)

;mostramos recomendaciones específicas según el grupo asignado y le asignamos una ruta predefinida que se imprime
(defrule matching::recomendar-asignar-ruta-grupo
   (grupo ?grupo)

   => 

    ; Clear console
    (printout t crlf)
    (printout t crlf)
    (printout t crlf)
    (printout t crlf)
    (printout t crlf)
    (printout t " =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!= " crlf)
    (printout t "               RECOMENDACIONES DE RUTAS POR EL MUSEO                     " crlf)
    (printout t " =!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!= " crlf)
    (printout t crlf)

    ; Segun el grupo asignado se recomienda una ruta inicial u otra
    (if (eq ?grupo BARROCO) then
        (printout t "RUTA BARROCA: Ideal para quienes disfrutan de la grandiosidad y el dramatismo. Disfrutarás de obras maestras de gran impacto visual del barroco." crlf)
         (bind ?ruta-inicial [Barroca])

    else (if (eq ?grupo EXPERTO) then
        (printout t "RUTA PARA EXPERTOS: Explora obras exclusivas y con más complejidad con análisis detallado y obras menos conocidas para profundizar en cada pieza." crlf)
        (bind ?ruta-inicial [Expertos]) 

    else (if (eq ?grupo GENERAL) then 
        (printout t "RUTA GENERAL: Recorre las exposiciones más destacadas para un paseo relajado y variado en estilos y autores, ideal para todos los niveles de conocimiento." crlf)
        (bind ?ruta-inicial [General])

    else (if (eq ?grupo MODERNISTA) then 
        (printout t "RUTA MODERNISTA: Enfocada en obras innovadoras y vanguardistas, ideal para amantes del arte contemporáneo con interés en la experimentación." crlf)
        (bind ?ruta-inicial [Modernista])      

    else (if (eq ?grupo NIÑOS) then 
        (printout t "RUTA PARA NIÑOS: Perfecta para familias con actividades interactivas y obras accesibles para los más pequeños, sin tanta complejidad." crlf)
        (bind ?ruta-inicial [Niños])

    else (if (eq ?grupo RENACENTISTA) then 
        (printout t "RUTA RENACENTISTA: Adéntrate en la precisión artística del Renacimiento, ideal para admiradores del equilibrio y la belleza clásica." crlf)
        (bind ?ruta-inicial [Renacentista])

    ))))))
    
    ; Guardamos la ruta inicial asignada para despues el refinamiento.
    (assert (ruta-inicial ?ruta-inicial))
    
    (focus refinamiento)
)

; Modulo de refinamiento, se encarga de ajustar la ruta inicial según las preferencias del visitante
(defmodule refinamiento (import MAIN ?ALL)(import matching ?ALL)(import recopilacion ?ALL)(export ?ALL))

; Pintar las obras de una ruta por sala
(deffunction refinamiento::pintar-obras-por-sala(?ruta)
    (if (> (length$ ?ruta) 0) then
       
        (bind ?sales (find-all-instances ((?sala Sala)) TRUE))

        ; Iterar sobre todas las salas, y para cada sala, imprimir las obras de la ruta que están expuestas en ella
        (foreach ?sal ?sales
            (bind ?obras-por-sala (find-all-instances ((?obra ObraDeArte))
                (and 
                    (member$ ?obra ?ruta)
                    (eq (send ?obra get-expuesta_en) ?sal)
                )
                )
            )
            ;Imprimir solo si hay obras de esa sala
            (if (> (length$ ?obras-por-sala) 0) then
                    (printout t crlf ?sal ":" crlf)
                (foreach ?obrasala ?obras-por-sala
                      (printout t "  - Obra: " ?obrasala crlf)
                      (printout t "         Autor: " (send ?obrasala get-creada_por) crlf)
                      (printout t "         Estilo: " (send ?obrasala get-obra_de_estilo) crlf)

                )
            )
        )
    )
)

; Añadir las obras del artista preferido a la ruta inicial, si el visitante tiene una preferencia de artista
(defrule refinamiento::añadir-preferencia-artista
    (preferencia-de-artista ?artista)
    (ruta-inicial ?ruta-inicial) ; Cambiado de $?ruta-inicial a ?ruta-inicial

    =>

    (bind ?lista-autor (create$))

    (bind ?lista-autor (send ?ruta-inicial get-ruta_contiene))

    ;Inserir obras del artista preferido a la ruta inicial
    (foreach ?obra (find-all-instances ((?obra ObraDeArte)) (eq ?obra:creada_por ?artista))
        (if (not (member$ ?obra ?lista-autor)) then
            (bind ?lista-autor (insert$ ?lista-autor 1 ?obra))
        )
    )

    ; Crea una nueva ruta con la mezcla de la ruta inicial y las obras del artista preferido
    (assert (lista-refinada1 ?lista-autor))
)

; Añadir las obras del estilo preferido a la lista refinada, si el visitante tiene una preferencia de estilo
(defrule refinamiento::añadir-preferencia-estilo
    (preferencia-de-estilo ?estilo)
    (lista-refinada1 $?lista-refinada1)
    
    =>

    (bind ?lista-estilo (create$))
    (bind ?lista-estilo ?lista-refinada1)

    ;Inserir obras del estilo preferido a la lista refinada
    (foreach ?obra (find-all-instances ((?obra ObraDeArte)) (eq ?obra:obra_de_estilo ?estilo))
        (if (not (member$ ?obra ?lista-estilo)) then
            (bind ?lista-estilo (insert$ ?lista-estilo 1 ?obra))
        )
    )

    ; Crea una nueva ruta con la mezcla de la lista refinada y las obras del estilo preferido
    (assert (lista-refinada2 ?lista-estilo))
)

; Devuelve la obra más compleja de la lista
(deffunction refinamiento::obra-mas-compleja (?lista)
    (bind ?obra-mas-compleja (nth$ 1 ?lista))

    ; Itera sobre todas las obras de la lista y compara sus dimensiones
    (foreach ?obra ?lista
        (if (> (send ?obra get-Dimensiones) (send ?obra-mas-compleja get-Dimensiones)) then
            (bind ?obra-mas-compleja ?obra)
        )
    )

    (return ?obra-mas-compleja)
)

; Devuelve la obra menos compleja de una lista de obras
(deffunction refinamiento::obra-menos-compleja (?lista)
    (bind ?obra-menos-compleja (nth$ 1 ?lista))

    ; Itera sobre todas las obras de la lista y compara sus dimensiones
    (foreach ?obra ?lista
        (if (< (send ?obra get-Dimensiones) (send ?obra-menos-compleja get-Dimensiones)) then
            (bind ?obra-menos-compleja ?obra)
        )
    )

    (return ?obra-menos-compleja)
)

; Ajustar la duración de la ruta eliminando obras si es necesario, se eliminan las obras más complejas o menos complejas dependiendo del tipo de visitante. O se insertan obras si sobra tiempo.
(defrule refinamiento::ajustar_tiempo
    (lista-refinada2 $?lista-refinada2)
    ?visita <- (object(is-a Visita)(nDias ?dias)(nHoras/Dia ?horas)(CONOCIMIENTO ?conocimiento)(TIPOGRUPO ?tipogrupo)(esFamilia ?ninos))

    =>

    (bind ?lista-tiempo (create$))
    (bind ?lista-tiempo ?lista-refinada2)

    ;dependiendo del tamaño del grupo y de si hay niños asignamos un tiempo por obra en minutos
    (bind ?tiempo-por-obra 
        (if (eq ?tipogrupo "individual") then
            2
        else (if  (and (eq ?tipogrupo "pequeño") (eq ?ninos FALSE))then
            5
        else (if (or (and (eq ?tipogrupo "pequeño") (eq ?ninos TRUE)) (and (eq ?tipogrupo "grande") (eq ?ninos FALSE))) then 
            10
        else (if (and (eq ?tipogrupo "grande") (eq ?ninos TRUE)) then
            15
        )))))

   
    (bind ?duracion-total (* ?dias ?horas 60)) ; en minutos
   ; (bind ?duracion-ruta (* (length$ ?lista-tiempo) 15)); 15 minutos por obra
    (bind ?duracion-ruta (* (length$ ?lista-tiempo) ?tiempo-por-obra));

    (bind ?duracion-museo-max (* ?tiempo-por-obra 75)) ; tiempo total para ver todas las 75 obras del museo

    

     (if (> ?duracion-ruta ?duracion-total) then             ; Si sobra tiempo, elimnamos tantas obras como sea necesario
        (bind ?diferencia (- ?duracion-ruta ?duracion-total))
        (while (> ?diferencia 0) do

            ; Eliminar la obra más compleja o menos compleja dependiendo del tipo de visitante
            (if (eq ?conocimiento "bajo") then
                (bind ?obra-a-eliminar (obra-mas-compleja ?lista-tiempo))
            else
                (bind ?obra-a-eliminar (obra-menos-compleja ?lista-tiempo))
            )
            (bind ?lista-tiempo (delete-member$ ?lista-tiempo ?obra-a-eliminar))
            (bind ?diferencia (- ?diferencia ?tiempo-por-obra)) ; tiempo-por-obra -> 15 
        )
        (bind ?duracion-ruta (* (length$ ?lista-tiempo) ?tiempo-por-obra)); tiempo-por-obra -> 15 minutos por obra

    ; Si falta tiempo, añadimos tantas obras como sea necesario
    else
        (bind ?diferencia (- ?duracion-total ?duracion-ruta))
        (bind ?obras (find-all-instances ((?obra ObraDeArte)) TRUE))
        (while (> ?diferencia 0) do
            ; Añadir la obra más compleja o menos compleja dependiendo del tipo de visitante
            (if (eq ?conocimiento "bajo") then
                (bind ?obra (obra-menos-compleja ?obras))
            else
                (bind ?obra (obra-mas-compleja ?obras))
            )

            ; Añadir la obra a la lista refinada, si no está ya
            (if (not (member$ ?obra ?lista-tiempo)) then
                (bind ?lista-tiempo (insert$ ?lista-tiempo 1 ?obra))
                (bind ?diferencia (- ?diferencia ?tiempo-por-obra)); tiempo-por-obra -> 15 minutos por obra

            )
            (bind ?obras (delete-member$ ?obras ?obra))
            (if (eq (length$ ?obras) 0) then    ; El tiempo disponible para su visita es superior al de visitar todo el museo, visitan todas las obras
                (break)
            )
        )
    )
    

    (assert (lista-final ?lista-tiempo))
)

; Pintar la ruta final
(defrule refinamiento::pintar-ruta-final
    (lista-final $?lista-final)

    =>

    (printout t crlf)
    (printout t "Ya hemos calculado cuál es la ruta que más se adaptará a usted. Verá a continuación una lista de salas con las obras que le recomendamos visitar en cada una de ellas. Esperamos que le guste la selección. Véala a continuación:" crlf)
    (printout t crlf)
    (pintar-obras-por-sala ?lista-final)
)
