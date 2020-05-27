#lang racket

(provide log)
(provide logX)
(provide IdentificarLength)
(provide MostrarCommits)

; Selectores

; Selector LocalRepository
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
                       (logX Zona)))

;Descripcion: LLama a una funcion que recibe como parametros el Local Repository y su Largo.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Funcion.
;Tipo de Recursion: Cola. 
(define (logX Zona) (IdentificarLength (CopiarLocalRepository Zona) (length (CopiarLocalRepository Zona))))

;Descripcion: Verifica la cantidad de commits para ver cuantos elementos hay que concatenar
;Dominio: Commits (Lista x Lista) y Legth (Entero).
;Recorrido: Funcion.
;Tipo de Recursion: Cola.
(define (IdentificarLength Commits Length) (if (<= Length 5) (MostrarCommits Commits Length)
                                              (MostrarCommits Commits 5)))

;Descripcion: Crea una lista con los 5 commits mas recientes.
;Dominio: Commits (Lista x Lista) y Legth (Entero).
;Recorrido: Lista.
;Tipo de Recursion: Natural.
(define (MostrarCommits Commits Length) (if (null? Commits) null
                                            (if (= Length 0) null
                                                (cons (car Commits) (MostrarCommits (cdr Commits) (- Length 1))))))

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Ej de uso:
;(display(log Zona))
;Solo se puede usar en ZonaDeTrabajo.rkt





