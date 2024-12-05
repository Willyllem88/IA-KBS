;;; ---------------------------------------------------------
;;; ontologia.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologia.ttl
;;; :Date 05/12/2024 14:34:12

(defclass Sala "Clase que representa una sala del museo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
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

(defclass Ruta
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ruta_contiene
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Artista "Clase que representa a una persona cuyo arte está en museos."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un artista pertenece al estilo en el que ha trabajado y ha sido reconocido
    (multislot artista_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (slot Nacionalidad
        (type STRING)
        (create-accessor read-write))
)

(defclass Estilo "Clase que representa un estilo/escuela/corriente/periodo pictórico."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot tipo
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
    (slot Dimensiones
        (type STRING)
        (create-accessor read-write))
    (slot añoCreacion
        (type SYMBOL)
        (create-accessor read-write))
    (slot época
        (type STRING)
        (create-accessor read-write))
)

(defclass Visita "Representa la clase visita, sera qualquier entidad que vaya a visitar el museo."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot preferencia_artista
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Los visitantes estan interesados por un estilo concreto
    (multislot preferencia_de_estilo
        (type INSTANCE)
        (create-accessor read-write))
    (slot nHoras/Dia
        (type SYMBOL)
        (create-accessor read-write))
    (slot CONOCIMIENTO
        (type SYMBOL)
        (create-accessor read-write))
    (slot DURACIÓN
        (type SYMBOL)
        (create-accessor read-write))
    (multislot ESTILOPREFERIDO
        (type STRING)
        (create-accessor read-write))
    (slot TIPOGRUPO
        (type STRING)
        (create-accessor read-write))
    (slot esFamilia
        (type SYMBOL)
        (create-accessor read-write))
    (slot nDias
        (type INTEGER)
        (create-accessor read-write))
    (multislot nMuseosVisitados
        (type SYMBOL)
        (create-accessor read-write))
    (slot nPersonas
        (type SYMBOL)
        (create-accessor read-write))
    (slot épocaInterés
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([Barroca] of Ruta
         (ruta_contiene  [Cleopatra] [ElJuicioDeParis] [JudithYSuDoncella] [LaAdoraciónDeLosMagos] [LaCenaDeEmaús] [LaFraguaDeVulcano] [LaRendiciónDeBreda] [Lucrecia] [SusanaYLosAncianos])
    )

    ([Expertos] of Ruta
         (ruta_contiene  [Amarillo-Rojo-Azul] [ComposiciónVII] [ElDescendimientoDeLaCruz] [ElJuicioFinal] [ElTriumfoDeBaco] [Improvisación28] [LaEscuelaDeAtenas] [LaUltimaCena] [LaVocaciónDeSanMateo])
    )

    ([General] of Ruta
         (ruta_contiene  [ElDescendimientoDeLaCruz] [Guernica] [JudithDecapitandoAHolofernes] [LaCreaciónDeAdán] [LaMonaLisa] [LaNocheEstrellada] [LaPersistenciaDeLaMemoria] [LaTransfiguración] [LasMeninas])
    )

    ([Modernista] of Ruta
         (ruta_contiene  [Amarillo-Rojo-Azul] [CisnesReflejandoElefantes] [ComposiciónVIII] [CuadradoConCírculosConcéntricos] [ElEstanqueDeNenúfares] [Guernica] [ImpresiónSolNaciente] [LaCatedralDeRuanEfectoDeSol] [LosGirasoles])
    )

    ([Niños] of Ruta
         (ruta_contiene  [CisnesReflejandoElefantes] [Cleopatra] [ImpresiónSolNaciente] [JudithYSuDoncella] [LaPersistenciaDeLaMemoria] [LosGirasoles] [MujerConSombrilla] [Nenúfares])
    )

    ([Renacentista] of Ruta
         (ruta_contiene  [ElHombreDeVitruvio] [LaCreaciónDeAdán] [LaMadonnaSixtina] [LaMonaLisa] [LaPiedad] [LaTransfiguración] [LaUltimaCena] [Moisés])
    )

    ([Amarillo-Rojo-Azul] of ObraDeArte
         (creada_por  [WassilyKandinsky])
         (expuesta_en  [Sala5])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  25400)
         (añoCreacion  1925)
    )

    ([Anunciación] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  21266)
         (añoCreacion  1472)
    )

    ([ArteModerno] of Estilo
    )

    ([ArtemisiaGentileschi] of Artista
    )

    ([AutorretratoComoAlegoríaDeLaPintura] of ObraDeArte
         (creada_por  [ArtemisiaGentileschi])
         (expuesta_en  [Sala6])
         (obra_de_estilo  [Barroco])
         (Dimensiones  7415)
         (añoCreacion  1639)
    )

    ([AutorretratoConDosCírculos] of ObraDeArte
         (creada_por  [RembrandtVanRijn])
         (expuesta_en  [Sala9])
         (obra_de_estilo  [Barroco])
         (Dimensiones  10763)
         (añoCreacion  1669)
    )

    ([AutorretratoConOrejaVendada] of ObraDeArte
         (creada_por  [VincentVanGogh])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  2940)
         (añoCreacion  1889)
    )

    ([Barroco] of Estilo
    )

    ([CampoDeTrigoConCuervos] of ObraDeArte
         (creada_por  [VincentVanGogh])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  5201)
         (añoCreacion  1890)
    )

    ([Caravaggio] of Artista
         (artista_de_estilo  [Barroco])
    )

    ([CisnesReflejandoElefantes] of ObraDeArte
         (creada_por  [SalvadorDalí])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  3927)
         (añoCreacion  1937)
    )

    ([ClaudeMonet] of Artista
         (artista_de_estilo  [ArteModerno])
    )

    ([Cleopatra] of ObraDeArte
         (creada_por  [ArtemisiaGentileschi])
         (expuesta_en  [Sala6])
         (obra_de_estilo  [Barroco])
         (Dimensiones  20533)
         (añoCreacion  1622)
    )

    ([ComposiciónVII] of ObraDeArte
         (creada_por  [WassilyKandinsky])
         (expuesta_en  [Sala5])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  60000)
         (añoCreacion  1913)
    )

    ([ComposiciónVIII] of ObraDeArte
         (creada_por  [WassilyKandinsky])
         (expuesta_en  [Sala5])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  28140)
         (añoCreacion  1923)
    )

    ([CristoCrucificado] of ObraDeArte
         (creada_por  [DiegoVelázquez])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  41912)
         (añoCreacion  1632)
    )

    ([CristoDeSanJuanDeLaCruz] of ObraDeArte
         (creada_por  [SalvadorDalí])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  23780)
         (añoCreacion  1951)
    )

    ([CuadradoConCírculosConcéntricos] of ObraDeArte
         (creada_por  [WassilyKandinsky])
         (expuesta_en  [Sala5])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  14400)
         (añoCreacion  1913)
    )

    ([Danae] of ObraDeArte
         (creada_por  [RembrandtVanRijn])
         (expuesta_en  [Sala9])
         (obra_de_estilo  [Barroco])
         (Dimensiones  37555)
         (añoCreacion  1636)
    )

    ([David] of ObraDeArte
         (creada_por  [MiguelAngel])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  517)
         (añoCreacion  1501)
    )

    ([DavidConLaCabezaDeGoliat] of ObraDeArte
         (creada_por  [Caravaggio])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  12625)
         (añoCreacion  1610)
    )

    ([DavidDonatello] of ObraDeArte
         (creada_por  [Donatello])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  158)
         (añoCreacion  1440)
    )

    ([DiegoVelázquez] of Artista
         (artista_de_estilo  [Barroco])
    )

    ([Donatello] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([ElDescendimientoDeLaCruz] of ObraDeArte
         (creada_por  [PeterPaulRubens])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  57640)
         (añoCreacion  1614)
    )

    ([ElEstanqueDeNenúfares] of ObraDeArte
         (creada_por  [ClaudeMonet])
         (expuesta_en  [Sala4])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  8181)
         (añoCreacion  1899)
    )

    ([ElFestínDeHerodes] of ObraDeArte
         (creada_por  [Donatello])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  3600)
         (añoCreacion  1425)
    )

    ([ElGranMasturbador] of ObraDeArte
         (creada_por  [SalvadorDalí])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  16500)
         (añoCreacion  1929)
    )

    ([ElGuitarristaViejo] of ObraDeArte
         (creada_por  [PabloPicasso])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  10151.54)
         (añoCreacion  1904)
    )

    ([ElHombreDeVitruvio] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  877)
         (añoCreacion  1490)
    )

    ([ElJardínDelAmor] of ObraDeArte
         (creada_por  [PeterPaulRubens])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  56628)
         (añoCreacion  1630)
    )

    ([ElJuicioDeParis] of ObraDeArte
         (creada_por  [PeterPaulRubens])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  75819)
         (añoCreacion  1636)
    )

    ([ElJuicioFinal] of ObraDeArte
         (creada_por  [MiguelAngel])
         (expuesta_en  [Sala7])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  1644000)
         (añoCreacion  1536)
    )

    ([ElNacimientoDeVenus] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  47816)
         (añoCreacion  1484)
    )

    ([ElRegresoDelHijopródigo] of ObraDeArte
         (creada_por  [RembrandtVanRijn])
         (expuesta_en  [Sala9])
         (obra_de_estilo  [Barroco])
         (Dimensiones  53710)
         (añoCreacion  1669)
    )

    ([ElRetabloDeSantaMaríaDelPopolo] of ObraDeArte
         (creada_por  [Rafael])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  85000)
         (añoCreacion  1516)
    )

    ([ElTriumfoDeBaco] of ObraDeArte
         (creada_por  [DiegoVelázquez])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  37125)
         (añoCreacion  1629)
    )

    ([Guernica] of ObraDeArte
         (creada_por  [PabloPicasso])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  270824)
         (añoCreacion  1937)
    )

    ([Habacuc] of ObraDeArte
         (creada_por  [Donatello])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  195)
         (añoCreacion  1423)
    )

    ([ImpresiónSolNaciente] of ObraDeArte
         (creada_por  [ClaudeMonet])
         (expuesta_en  [Sala4])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  3024)
         (añoCreacion  1872)
    )

    ([Improvisación28] of ObraDeArte
         (creada_por  [WassilyKandinsky])
         (expuesta_en  [Sala5])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  17982)
         (añoCreacion  1912)
    )

    ([JudithDecapitandoAHolofernes] of ObraDeArte
         (creada_por  [Caravaggio])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  28080)
         (añoCreacion  1599)
    )

    ([JudithYSuDoncella] of ObraDeArte
         (creada_por  [ArtemisiaGentileschi])
         (expuesta_en  [Sala6])
         (obra_de_estilo  [Barroco])
         (Dimensiones  10659)
         (añoCreacion  1619)
    )

    ([LaAdoraciónDeLosMagos] of ObraDeArte
         (creada_por  [PeterPaulRubens])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  156064)
         (añoCreacion  1624)
    )

    ([LaCalumniaDeApeles] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  5642)
         (añoCreacion  1495)
    )

    ([LaCatedralDeRuanEfectoDeSol] of ObraDeArte
         (creada_por  [ClaudeMonet])
         (expuesta_en  [Sala4])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  6500)
         (añoCreacion  1893)
    )

    ([LaCenaDeEmaús] of ObraDeArte
         (creada_por  [Caravaggio])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  27580)
         (añoCreacion  1601)
    )

    ([LaCreaciónDeAdán] of ObraDeArte
         (creada_por  [MiguelAngel])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  5600000)
         (añoCreacion  1512)
    )

    ([LaDamaDelArmiño] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  2106)
         (añoCreacion  1489)
    )

    ([LaEscuelaDeAtenas] of ObraDeArte
         (creada_por  [Rafael])
         (expuesta_en  [Sala7])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  385000)
         (añoCreacion  1510)
    )

    ([LaFraguaDeVulcano] of ObraDeArte
         (creada_por  [DiegoVelázquez])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  64670)
         (añoCreacion  1630)
    )

    ([LaHabitaciónEnArlés] of ObraDeArte
         (creada_por  [VincentVanGogh])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  6480)
         (añoCreacion  1888)
    )

    ([LaIncredulidadDeSantoTomás] of ObraDeArte
         (creada_por  [Caravaggio])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  15622)
         (añoCreacion  1602)
    )

    ([LaLecciónDeAnatomíaDelDr.Tulp] of ObraDeArte
         (creada_por  [RembrandtVanRijn])
         (expuesta_en  [Sala9])
         (obra_de_estilo  [Barroco])
         (Dimensiones  36697)
         (añoCreacion  1632)
    )

    ([LaMadonnaDelJilguero] of ObraDeArte
         (creada_por  [Rafael])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  8239)
         (añoCreacion  1505)
    )

    ([LaMadonnaSixtina] of ObraDeArte
         (creada_por  [Rafael])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  51940)
         (añoCreacion  1512)
    )

    ([LaMonaLisa] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  4081)
         (añoCreacion  1503)
    )

    ([LaMujerQueLlora] of ObraDeArte
         (creada_por  [PabloPicasso])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  2940)
         (añoCreacion  1937)
    )

    ([LaNocheEstrellada] of ObraDeArte
         (creada_por  [VincentVanGogh])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  6787.77)
         (añoCreacion  1889)
    )

    ([LaPersistenciaDeLaMemoria] of ObraDeArte
         (creada_por  [SalvadorDalí])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  792)
         (añoCreacion  1931)
    )

    ([LaPiedad] of ObraDeArte
         (creada_por  [MiguelAngel])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  33930)
         (añoCreacion  1498)
    )

    ([LaPrimavera] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  63742)
         (añoCreacion  1482)
    )

    ([LaRendiciónDeBreda] of ObraDeArte
         (creada_por  [DiegoVelázquez])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  112669)
         (añoCreacion  1635)
    )

    ([LaRondaDeNoche] of ObraDeArte
         (creada_por  [RembrandtVanRijn])
         (expuesta_en  [Sala9])
         (obra_de_estilo  [Barroco])
         (Dimensiones  158631)
         (añoCreacion  1642)
    )

    ([LaTransfiguración] of ObraDeArte
         (creada_por  [Rafael])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  114390)
         (añoCreacion  1516)
    )

    ([LaUltimaCena] of ObraDeArte
         (creada_por  [LeonardoDaVinci])
         (expuesta_en  [Sala7])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  404800)
         (añoCreacion  1495)
    )

    ([LaVirgenDelLibro] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  2262)
         (añoCreacion  1480)
    )

    ([LaVocaciónDeSanMateo] of ObraDeArte
         (creada_por  [Caravaggio])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  109480)
         (añoCreacion  1600)
    )

    ([LasMeninas] of ObraDeArte
         (creada_por  [DiegoVelázquez])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  87768)
         (añoCreacion  1656)
    )

    ([LasTresGracias] of ObraDeArte
         (creada_por  [PeterPaulRubens])
         (expuesta_en  [Sala2])
         (obra_de_estilo  [Barroco])
         (Dimensiones  40001)
         (añoCreacion  1635)
    )

    ([LeonardoDaVinci] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([LesDemoisellesDAvignon] of ObraDeArte
         (creada_por  [PabloPicasso])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  56999.43)
         (añoCreacion  1907)
    )

    ([LosGirasoles] of ObraDeArte
         (creada_por  [VincentVanGogh])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  6696)
         (añoCreacion  1888)
    )

    ([Lucrecia] of ObraDeArte
         (creada_por  [ArtemisiaGentileschi])
         (expuesta_en  [Sala6])
         (obra_de_estilo  [Barroco])
         (Dimensiones  7700)
         (añoCreacion  1625)
    )

    ([MiguelAngel] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([Moisés] of ObraDeArte
         (creada_por  [MiguelAngel])
         (expuesta_en  [Sala1])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  235)
         (añoCreacion  1513)
    )

    ([MujerConSombrilla] of ObraDeArte
         (creada_por  [ClaudeMonet])
         (expuesta_en  [Sala4])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  8100)
         (añoCreacion  1875)
    )

    ([Nenúfares] of ObraDeArte
         (creada_por  [ClaudeMonet])
         (expuesta_en  [Sala4])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  255200)
         (añoCreacion  1926)
    )

    ([PabloPicasso] of Artista
         (artista_de_estilo  [ArteModerno])
    )

    ([PalasYElCentauro] of ObraDeArte
         (creada_por  [SandroBotticelli])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  30636)
         (añoCreacion  1482)
    )

    ([PenitenteMagdalena] of ObraDeArte
         (creada_por  [Donatello])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  188)
         (añoCreacion  1455)
    )

    ([PeterPaulRubens] of Artista
         (artista_de_estilo  [Barroco])
    )

    ([Rafael] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([RembrandtVanRijn] of Artista
         (artista_de_estilo  [Barroco])
    )

    ([Renacimiento] of Estilo
    )

    ([RetratoDeDoraMaar] of ObraDeArte
         (creada_por  [PabloPicasso])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  5980)
         (añoCreacion  1937)
    )

    ([Sala1] of SalaTematica
         (sala_sobre_estilo  [Renacimiento])
    )

    ([Sala2] of SalaTematica
         (sala_sobre_estilo  [Barroco])
    )

    ([Sala3] of SalaTematica
         (sala_sobre_estilo  [ArteModerno])
    )

    ([Sala4] of SalaArtista
         (exhibe_obras_de  [ClaudeMonet])
    )

    ([Sala5] of SalaArtista
         (exhibe_obras_de  [WassilyKandinsky])
    )

    ([Sala6] of SalaArtista
         (exhibe_obras_de  [ArtemisiaGentileschi])
    )

    ([Sala7] of SalaTematica
         (sala_sobre_estilo  [Renacimiento])
    )

    ([Sala8] of SalaTematica
         (sala_sobre_estilo  [Renacimiento])
    )

    ([Sala9] of SalaArtista
         (exhibe_obras_de  [RembrandtVanRijn])
    )

    ([SalvadorDalí] of Artista
         (artista_de_estilo  [ArteModerno])
    )

    ([SanJorge] of ObraDeArte
         (creada_por  [Donatello])
         (expuesta_en  [Sala8])
         (obra_de_estilo  [Renacimiento])
         (Dimensiones  209)
         (añoCreacion  1416)
    )

    ([SandroBotticelli] of Artista
         (artista_de_estilo  [Renacimiento])
    )

    ([SueñoCausadoPorElVueloDeUnaAbeja] of ObraDeArte
         (creada_por  [SalvadorDalí])
         (expuesta_en  [Sala3])
         (obra_de_estilo  [ArteModerno])
         (Dimensiones  2091)
         (añoCreacion  1944)
    )

    ([SusanaYLosAncianos] of ObraDeArte
         (creada_por  [ArtemisiaGentileschi])
         (expuesta_en  [Sala6])
         (obra_de_estilo  [Barroco])
         (Dimensiones  20570)
         (añoCreacion  1610)
    )

    ([VincentVanGogh] of Artista
         (artista_de_estilo  [ArteModerno])
    )

    ([WassilyKandinsky] of Artista
         (artista_de_estilo  [ArteModerno])
    )

)
