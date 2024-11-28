;;; ---------------------------------------------------------
;;; ontologia.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia.ttl
;;; :Date 28/11/2024 14:48:36

(defclass Sala "Clase que representa una sala del museo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Una sala es una SalaTemática o SalaArtista
    (slot es_una
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Una sala forma parte de un museo
    (slot parte_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass SalaArtista "Subclase que representa esas salas del muso cuyo interés es mostrar las obras de un pintor en concreto."
    (is-a Sala)
    (role concrete)
    (pattern-match reactive)
    ;;; Una SalaArtista está basada en las obras de un artista
    (multislot exhibe_obras_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass SalaTematica "Representa una sala del muso cuyo interés es que todas sus obrás serán de la misma temática."
    (is-a Sala)
    (role concrete)
    (pattern-match reactive)
    ;;; Una sala temática está basada en un estilo concreto
    (slot sala_sobre_estilo
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Visita "Representa la clase visita, sera qualquier entidad que vaya a visitar el museo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Una visita puede ser grupal o individual
    (slot es_un
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Los visitantes estan interesados por un estilo concreto
    (multislot preferencia_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (multislot duración
        (type SYMBOL)
        (create-accessor read-write))
    (multislot nDias
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Grupo "Será un conjunto de personas que vayan a visitar el museo. Puden ser tanto grupos de personas adultas, como famílias."
    (is-a Visita)
    (role concrete)
    (pattern-match reactive)
    (multislot esFamilia
        (type SYMBOL)
        (create-accessor read-write))
    (multislot nPersonas
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Persona "Es un tipo de visitante, este irá al museo sin acompañante."
    (is-a Visita)
    (role concrete)
    (pattern-match reactive)
)

(defclass Artista "Clase que representa a una persona cuyo arte está en museos."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un artista pertenece al estilo en el que ha trabajado y ha sido reconocido
    (multislot artista_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (multislot Nacionalidad
        (type STRING)
        (create-accessor read-write))
)

(defclass Estilo "Clase que representa un estilo/escuela/corriente/periodo pictórico."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot tipo
        (type STRING)
        (create-accessor read-write))
)

(defclass Museo "Clase que representa un museo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass ObraDeArte "Clase que representa una obra de arte."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Obra hecha por el artista
    (slot creada_por
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Se encuentra ubicado dentro de una sala
    (multislot expuesta_en
        (type INSTANCE)
        (create-accessor read-write))
    ;;; El estilo al que pertenece una obra
    (slot obra_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (multislot Dimensiones
        (type STRING)
        (create-accessor read-write))
    (multislot añoCreacion
        (type SYMBOL)
        (create-accessor read-write))
    (multislot época
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
)
