(defmodule MAIN (export ?ALL))

;módulo MAIN, punto de inicio
(defrule MAIN::inicio
=>
(printout t "Sea usted bienvenido al nustro sistema de recomendacions de rutas por el museo." crlf)
(printout t"Para poder hacerle una visita que se adapte a usted lo mejor posble, responda a las siguentes preguntas." crlf)
(focus recopilacion)
)

;módulo para recopilar datos del usuario
(defmodule recopilacion (import MAIN ?ALL)(export ?ALL))

(deffunction recopilacion::pregunta-comprobar-int(?mensaje)
    (printout t ?mensaje crlf)
    (bind ?respuesta (read))
    (while (not (integerp ?respuesta)) do
        (printout t "  ERROR: Por favor, introduce un número entero." crlf)
        (bind ?respuesta (read))
    )
    return ?respuesta
)

(deffunction recopilacion::pregunta-comprobar-boolean(?mensaje)
    (printout t ?mensaje crlf)
    (bind ?respuesta (read))
    (while (not (or (eq ?respuesta "si") (eq ?respuesta "no"))) do
        (printout t "  ERROR: Por favor, introduce 'si' o 'no'." crlf)
        (bind ?respuesta (read))
    )
    return ?respuesta
)

; TODO: deixar d'utilitzar aquest mètode i utilitzar el mètode pregunta-comprobar
(deffunction recopilacion::pregunta-datos (?pregunta)
    (format t "%s: " ?pregunta)
    (bind ?respuesta (read))
    ?respuesta
)

; TODO: utilitzar un mètode que recopili tota la informació en un sol mètode defrule recopilacion::preguntar-datos
;(defrule recopilacion::preguntar-datos
;    ?visita <- (object (is_a Visita))
;
;    =>
;
;)

;; Pregunta número de personas del grupo y, en caso de ser >1, pregunta también si hay niños
(defrule recopilacion::preguntar-numero-personas
    "Pregunta al usuario cuántas personas forman el grupo"
    =>
    ;; Preguntar al usuario
    (bind ?Personas (pregunta-comprobar-int "¿Cuántas personas sois?"))
    (assert (datos-personas ?Personas))
    
    ;;Determinar el tipo de grupo (tipoGrupo)
    (if (<= ?Personas 1) then
        ;; Si solo hay una persona, asignamos tipo 'individual' y creamos una instancia de Persona
        (assert (tipoGrupo "individual")) 
        (assert (esFamilia false))
    )
    (if (> ?Personas 1) then
        ;; Si hay más de una persona, asignamos tipo 'pequeño' o 'grande' según corresponda
        (if (<= ?Personas 4) then
            (assert (tipoGrupo "pequeno"))
        else
            (assert (tipoGrupo "grande"))
        )
        
        ;;Si es un grupo, preguntar si hay niños
    		(bind ?hayNinos (pregunta-datos "¿Hay niños en el grupo? (si/no)"))

    		;; Si la respuesta es sí, se marca como una familia
    		(if (eq ?hayNinos si) then
        		(assert (esFamilia true))
    		else
        		(assert (esFamilia false))
    		)
        
    )
)

(defrule recopilacion::preguntar-dias-visita
    "Pregunta al usuario cuántos días tienen para realizar la visita"
    (datos-personas ?Personas)
    =>
    ;; Preguntar al usuario
    (bind ?dias (pregunta-datos "¿Cuántos días durará vuestra visita?"))
    (assert (datos-dias ?dias))
)

(defrule recopilacion::preguntar-horas-visita
    "Pregunta al usuario cuántas horas tienen dedicarán cada día a la visita"
    (datos-dias ?dias)
    =>
    ;; Preguntar al usuario
    (bind ?horas (pregunta-datos "¿Cuántas horas dedicareis cada día a vuestra visita?"))
    (assert (datos-horas ?horas))
)

(defrule recopilacion::preguntar-conocimiento
    "Pregunta al usuario cuántos museos han visitado en el último año"
    (datos-horas ?horas)
    =>
    ;; Preguntar
    (bind ?museos (pregunta-datos "¿Cuántos museos habéis visitado en el último año?"))
    (if (<= ?museos 1) then ;; si han visitado uno o menos, el conocimiento es bajo
        (bind ?conocimiento "bajo")
    )
    (if (and (> ?museos 1) (<= ?museos 5)) then
        (bind ?conocimiento "mediano")
    )
    (if (> ?museos 5) then
        (bind ?conocimiento "alto")
    )
    (assert (datos-conocimiento ?conocimiento))
)

(defrule recopilacion::preguntar-estilo-preferencia
    "Pregunta al usuario por qué estilo tiene preferencia (de los disponibles en nuestro museo)"
   (datos-conocimiento ?conocimiento)
   =>
   (bind $?instancias-estilo (find-all-instances ((?inst Estilo)) TRUE))
   (bind $?nombres-estilo (create$))  ;; Crear lista vacía

   ;;Itera sobre todas las instancias de estilos
   (loop-for-count (?i 1 (length$ $?instancias-estilo)) do
      (bind ?instancia (nth$ ?i $?instancias-estilo))  ;; cada instancia
      ;; Si la lista está vacía, agrega el primer elemento, sino agrega al final
      (if (eq (length$ $?nombres-estilo) 0) then
         (bind $?nombres-estilo (insert$ $?nombres-estilo 1 ?instancia))
         else
         (bind $?nombres-estilo (insert$ $?nombres-estilo (length$ $?nombres-estilo) ?instancia))
      )
   )

   (printout t "Introduce el número del estilo que prefieras: " crlf)

   ;;Imprime la lista de estilos
   (loop-for-count (?i 1 (length$ $?nombres-estilo)) do
      (printout t ?i ". " (nth$ ?i $?nombres-estilo) crlf))

   ;;Leer la respuesta
   (bind ?eleccion (read))

   ;;Comprobar si respuesta válida
   (if (and (>= ?eleccion 1) (<= ?eleccion (length$ $?nombres-estilo)))
      then
      (bind ?estilo (nth$ ?eleccion $?nombres-estilo))
      (assert (preferencia-de-estilo ?estilo))  ;;Guardar respuesta
      else
      (printout t "Opción no válida." crlf))
)

(defrule recopilacion::preguntar-artista-preferencia
    "Pregunta al usuario por qué artista tiene preferencia, dentro del estilo que ha escogido en la pregunta anterior (de los disponibles en nuestro museo)"
   (preferencia-de-estilo ?estilo)
   =>
   (bind $?instancias-artistas (find-all-instances ((?inst Artista)) TRUE))
   (bind $?nombres-artistas (create$))  ;; Crear lista vacía

   ;; Itera sobre todas las instancias de artistas
   (loop-for-count (?i 1 (length$ $?instancias-artistas)) do
      (bind ?instancia (nth$ ?i $?instancias-artistas))  ;; cada instancia
      ;; Si la lista está vacía, agrega el primer elemento, sino agrega al final
      (if (eq (length$ $?nombres-artistas) 0) then
         (bind $?nombres-artistas (insert$ $?nombres-artistas 1 ?instancia))
         else
         (bind $?nombres-artistas (insert$ $?nombres-artistas (length$ $?nombres-artistas) ?instancia))
      )
   )

   (printout t "Introduce el número del artista que prefieras: " crlf)

   ;;Imprime la lista de artistas
   (loop-for-count (?i 1 (length$ $?nombres-artistas)) do
      (printout t ?i ". " (nth$ ?i $?nombres-artistas) crlf))

   ;;Leer la respuesta
   (bind ?eleccion (read))

   ;;Comprobar si respuesta válida
   (if (and (>= ?eleccion 1) (<= ?eleccion (length$ $?nombres-artistas)))
      then
      (bind ?artista (nth$ ?eleccion $?nombres-artistas))
      (assert (preferencia-de-artista ?artista))  ;;Guardar la preferencia
      else
      (printout t "Opción no válida." crlf))
)

(defrule recopilacion::crear-visita
    "Crea una instancia de Visita con el número de días indicados"
    (datos-personas ?Personas)
    (tipoGrupo ?tipoGrupo)
    (esFamilia ?esFamilia)
    (datos-dias ?dias) ;; Captura el hecho con el número de días
    (datos-horas ?horas)
    (datos-conocimiento ?conocimiento)
    (preferencia-de-estilo ?estilo)
    (preferencia-de-artista ?artista)
    =>
    (bind ?duracion (* ?dias ?horas))
    ;; Crear la instancia de Visita
    (make-instance [visita1] of Visita
    	  (tipoGrupo ?tipoGrupo)
        (nDias ?dias)
        (nHoras/Dia ?horas)
        (duración ?duracion)
        (conocimiento ?conocimiento)
        ) ;; Asignamos valores preguntados anteriormente
        
    ;; Relacionar la visita con el estilo preferido
	(assert (preferencia_de_estilo visita1 ?estilo))
	 ;;(bind ?visita (find-instance visita1))
    ;;(modify ?visita (preferencia_de_estilo (create$ ?estilo)))
    (assert (preferencia_artista visita1 ?artista))
    
    ;; Tipo de grupo, subclase Individual o Grupo y esFamilia
    
    (if (<= ?Personas 1) then
        (make-instance persona1 of Persona
        		(es_un Visita))
    )
    (if (> ?Personas 1) then
        (make-instance grupo1 of Grupo 
        		(es_un Visita)
        		(nPersonas ?Personas) (esFamilia ?esFamilia))
    )

    (printout t "Instancia de Visita creada con " ?dias " días disponibles, "?horas" horas, "?duracion" duración y "?conocimiento" conocimiento." crlf)
    (printout t "La visita tiene preferencia por el estilo: " ?estilo crlf)
    (printout t "La visita tiene preferencia por el artista: " ?artista crlf)
    (printout t "La visita es de " ?Personas " personas, tipoGrupo: " ?tipoGrupo " y esFamilia: " ?esFamilia crlf)
)

;módulo de abstracción
(defmodule abstraccion (import MAIN ?ALL)(import recopilacion ?ALL)(export ?ALL))
