#lang racket

;Eliminar Duplicados

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto9.c" "Texto10.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list "Commit" "Texto1.c" "Texto2.c"))

(define RemoteRepository
  (list "Texto3.c" "Texto4.c" "Texto5.c" "texto7.c" (list (list "Commit" "Texto3.c" "Texto4.c") (list "Commit5" "Texto7.c"))))

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

;Lista Auxiliar
(define Listaux (list ))
                           
;--------------------------------- Pull -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

(define (pull Zona) (ZonaTrabajo (Concatenar (CopiarWorkspace Zona) (pull2 (cadddr Zona) Listaux))
                                 (CopiarIndex Zona)
                                 (CopiarLocalRepository Zona)
                                 (CopiarRemoteRepository Zona)
                                 (Concatenar (CopiarRegistros Zona)(list "->Pull"))))

(define (pull2 RemoteRepository Listaux) (if (list? (car RemoteRepository)) Listaux 
                                     (pull2 (cdr RemoteRepository) (Concatenar Listaux (list (car RemoteRepository))))))

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------