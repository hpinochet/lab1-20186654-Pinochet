#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list )
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list "Commit" "Texto1.c" "Texto2.c"))

(define RemoteRepository
  (list "Texto1.c" "Texto2.c" "Texto321.c" (list "Commit" "Texto1.c" "Texto2.c" "Texto321.c")))

(define Registros
  (list ))

; Selectores

; Selector Workspace
(define (CopiarWorkspace ZonaTrabajo) (car ZonaTrabajo))

; Selector Index
(define (CopiarIndex ZonaTrabajo) (cadr ZonaTrabajo))

; Selector LocalRepository
(define (CopiarLocalRepository ZonaTrabajo) (caddr ZonaTrabajo))

; Selector RemoteRepository
(define (CopiarRemoteRepository ZonaTrabajo)
  (cadddr ZonaTrabajo))

; Selector Registros
(define (CopiarRegistros ZonaTrabajo) (car (cddddr ZonaTrabajo)))

;Concatenar
(define (Concatenar L1 L2) (if (null? L1) L2
     (cons (car L1) (Concatenar (cdr L1) L2))))
                           
;--------------------------------- Pull -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

(define (pull Zona) (ZonaTrabajo (pull2 (cadddr Zona))
                                       (CopiarIndex Zona)
                                       (CopiarLocalRepository Zona)
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->Pull"))))

(define (pull2 RemoteRepository) (if (list? (car RemoteRepository)) null 
                                     (cons (car RemoteRepository) (pull2 (cdr RemoteRepository)))))

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------