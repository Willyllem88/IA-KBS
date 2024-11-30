;;; ---------------------------------------------------------
;;; ontologia.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia.owl
;;; :Date 30/11/2024 16:37:28

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

(defclass SalaArtista "Subclase que representa esas salas del muso cuyo interés es mostrar las obras de un autor en concreto."
    (is-a Sala)
    (role concrete)
    (pattern-match reactive)
    ;;; Una SalaArtista está basada en las obras de un artista
    (multislot exhibe_obras_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass SalaTematica "Representa una sala del muso cuyo interés es que todas sus obros serán de la misma temática."
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
    (slot preferencia_artista
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Los visitantes estan interesados por un estilo concreto
    (multislot preferencia_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (multislot nHoras/Dia
        (type SYMBOL)
        (create-accessor read-write))
    (multislot conocimiento
        (type SYMBOL)
        (create-accessor read-write))
    (multislot duración
        (type SYMBOL)
        (create-accessor read-write))
    (multislot nDias
        (type INTEGER)
        (create-accessor read-write))
    (multislot tipoGrupo
        (type STRING)
        (create-accessor read-write))
    (slot épocaInterés
        (type STRING)
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
        (type STRING)
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
    ([Anunciación] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (Dimensiones  21266)
         (añoCreacion  1472)
    )

    ([David] of ObraDeArte
         (creada_por  [MiguelAngel])
         (Dimensiones  517)
         (añoCreacion  1501)
    )

    ([DavidDonatello] of ObraDeArte
         (creada_por  [Donatello])
         (Dimensiones  158)
         (añoCreacion  1440)
    )

    ([Donatello] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([ElFestínDeHerodes] of ObraDeArte
         (creada_por  [Donatello])
         (Dimensiones  3600)
         (añoCreacion  1425)
    )

    ([ElHombreDeVitruvio] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (Dimensiones  877)
         (añoCreacion  1490)
    )

    ([ElJuicioFinal] of ObraDeArte
         (creada_por  [MiguelAngel])
         (Dimensiones  1644000)
         (añoCreacion  1536)
    )

    ([ElNacimientoDeVenus] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (Dimensiones  47816)
         (añoCreacion  1484)
    )

    ([ElRetabloDeSantaMaríaDelPopolo] of ObraDeArte
         (creada_por  [Rafael])
         (Dimensiones  85000)
         (añoCreacion  1516)
    )

    ([Habacuc] of ObraDeArte
         (creada_por  [Donatello])
         (Dimensiones  195)
         (añoCreacion  1423)
    )

    ([LaAdoraciónDeLosMagos] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (Dimensiones  14874)
         (añoCreacion  1476)
    )

    ([LaCalumniaDeApeles] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (Dimensiones  5642)
         (añoCreacion  1495)
    )

    ([LaCreaciónDeAdán] of ObraDeArte
         (creada_por  [MiguelAngel])
         (Dimensiones  5600000)
         (añoCreacion  1512)
    )

    ([LaDamaDelArmiño] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (Dimensiones  2106)
         (añoCreacion  1489)
    )

    ([LaEscuelaDeAtenas] of ObraDeArte
         (creada_por  [Rafael])
         (Dimensiones  385000)
         (añoCreacion  1510)
    )

    ([LaMadonnaDelJilguero] of ObraDeArte
         (creada_por  [Rafael])
         (Dimensiones  8239)
         (añoCreacion  1505)
    )

    ([LaMadonnaSixtina] of ObraDeArte
         (creada_por  [Rafael])
         (Dimensiones  51940)
         (añoCreacion  1512)
    )

    ([LaPiedad] of ObraDeArte
         (creada_por  [MiguelAngel])
         (Dimensiones  33930)
         (añoCreacion  1498)
    )

    ([LaPrimavera] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (Dimensiones  63742)
         (añoCreacion  1482)
    )

    ([LaTransfiguración] of ObraDeArte
         (creada_por  [Rafael])
         (Dimensiones  114390)
         (añoCreacion  1516)
    )

    ([LaUltimaCena] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (Dimensiones  404800)
         (añoCreacion  1495)
    )

    ([LaVirgenDelLibro] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (Dimensiones  2262)
         (añoCreacion  1480)
    )

    ([MiguelAngel] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([Moisés] of ObraDeArte
         (creada_por  [MiguelAngel])
         (Dimensiones  235)
         (añoCreacion  1513)
    )

    ([PenitenteMagdalena] of ObraDeArte
         (creada_por  [Donatello])
         (Dimensiones  188)
         (añoCreacion  1455)
    )

    ([Rafael] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([SanJorge] of ObraDeArte
         (creada_por  [Donatello])
         (Dimensiones  209)
         (añoCreacion  1416)
    )

    ([SandroBotticelli] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([LaMonaLisa] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (Dimensiones  4081)
         (añoCreacion  1503)
    )

    ([LeonardoDaVinci] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([Renacimiento] of Estilo
    )

)
