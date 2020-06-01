#lang racket

;Se envian funciones
(provide log)

; Selectores

; Selector LocalRepository
; Descripcion: Copiar la Informacion de Local Repository,
; Dominio: ZonaTrabajo(ListaxLista)
; Recorrido: Local Repository.
; Tipo de Recursion: Cola.
(define (CopiarLocalRepository ZonaTrabajo) (caddr ZonaTrabajo))


;--------------------------------- Log -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Nota: Se obtienen los primeros 5 commits debido a que la funcion commit,
;       automaticamemte deja en las primeras pociciones los commits mas recientes.

;Descripcion: Llama al procedimiento Log y verifica si es que hay o no Commits.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Print o Procedimiento.
;Tipo de Recursion: Cola.
(define (log Zona) (if (null? (CopiarLocalRepository Zona)) "No hay Commits en el RemoteRepository"
                       (string-append "\nLos commits mas recientes son:\n" (logX Zona) "\n\n")))

;Descripcion: LLama a una funcion que recibe como parametros el Local Repository y su Largo.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Funcion.
;Tipo de Recursion: Cola. 
(define (logX Zona) (IdentificarLength (CopiarLocalRepository Zona) (length (CopiarLocalRepository Zona))))

;Descripcion: Verifica la cantidad de commits para ver cuantos elementos hay que concatenar
;Dominio: Commits (Lista x Lista) y Length (Entero).
;Recorrido: Funcion.
;Tipo de Recursion: Cola.
(define (IdentificarLength Commits Length) (if (<= Length 5) (MostrarCommits Commits Length)
                                              (MostrarCommits Commits 5)))

;Descripcion: Crea string con los commits mas recientes.
;Dominio: Commits (Lista x Lista) y Length (Entero).
;Recorrido: String.
;Tipo de Recursion: Natural.
(define (MostrarCommits Commits Length) (if (null? Commits) " "
                                            (if (= Length 0) " "
                                                (string-append "\n - " (string-append "(" (ArchivosCommit (car Commits))")" (MostrarCommits (cdr Commits) (- Length 1)))))))

; Descripcion: Convierte en string el contenido de los commits.
; Dominio: Commit (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (ArchivosCommit Commit) (if (null? (cdr Commit)) (car Commit)
                                                (string-append (car Commit) " " (ArchivosCommit (cdr Commit)))))

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------