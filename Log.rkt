#lang racket

(provide log)
(provide EncontrarCommits)
(provide logX)
(provide IdentificarLength)
(provide MostrarCommits)

; Selectores

; Selector RemoteRepository
(define (CopiarRemoteRepository ZonaTrabajo) (cadddr ZonaTrabajo))


;--------------------------------- Log -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Nota: Se obtienen los primeros 5 commits debido a que la funcion push y commit,
;       automaticamemte deja en las primeras pociciones los commits mas recientes.

(define (log Zona) (if (null? (CopiarRemoteRepository Zona)) "No hay Commits en el RemoteRepository"
                       (logX Zona)))

(define (EncontrarCommits RemoteRepository) (if (list? (car RemoteRepository)) (car RemoteRepository)
                                                (EncontrarCommits (cdr RemoteRepository))))

(define (logX Zona) (IdentificarLength (EncontrarCommits (CopiarRemoteRepository Zona)) (length (EncontrarCommits (CopiarRemoteRepository Zona)))))

(define (IdentificarLength Commits Length) (if (<= Length 5) (MostrarCommits Commits Length)
                                              (MostrarCommits Commits 5)))

(define (MostrarCommits Commits Length) (if (null? Commits) null
                                            (if (= Length 0) null
                                                (cons (car Commits) (MostrarCommits (cdr Commits) (- Length 1))))))

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Ej de uso:

; (define Zona(ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros))
; (display(log Zona))






