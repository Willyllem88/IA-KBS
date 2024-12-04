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
    (return ?respuesta)
)

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
    (printout t "Datos recopilados (variables):" crlf)
    (printout t "  Personas: " ?personas crlf)
    (printout t "  Niños: " ?niños crlf)
    (printout t "  Días: " ?dias crlf)
    (printout t "  Horas: " ?horas crlf)
    (printout t "  Museos: " ?museos crlf)
    (printout t "  Estilo: " ?estilo crlf)
    (printout t "  Artista: " ?artista crlf)

    ;Crear la instancia de Visita
    (if (> ?personas 1) 
        then
            (bind ?grupo (make-instance [grupo1] of Grupo
                (nDias ?dias)
                (nHoras/Dia ?horas)
                ;TODO: falta atribut de Visita nMuseos
                (nPersonas ?personas)
                (esFamilia (eq ?niños si))
                )
            )
            (assert (preferencia-de-estilo ?estilo))
            (assert (preferencia-de-artista ?artista))
        else 
            (make-instance [persona1] of Persona
                (nDias ?dias)
                (nHoras/Dia ?horas)
                ;TODO: falta atribut de Visita nMuseos
            )
            (assert (preferencia-de-estilo ?estilo))
            (assert (preferencia-de-artista ?artista))
    )

    ;DEBUG: mostrar datos recopilados (atributos de la instancia)
    (printout t "Datos recopilados (atributos de la instancia):" crlf)
    ;TODO: falta mostrar atributos de la instancia creada
)