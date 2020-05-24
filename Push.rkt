#lang racket

; Eliminar repetidos pendiente

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list (list "Commit1" "Texto3.c" "Texto4.c") (list "Commit2" "Texto5.c" "Texto6.c") (list "Commit3" "Texto7.c" "Texto8.c")))

(define RemoteRepository
  (list ))

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
                           
;--------------------------------- Push --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
; Solo soporta un commit

(define (push Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       (CopiarLocalRepository Zona)
                                       (Concatenar (push2 (caddr Zona)) (list(CopiarLocalRepository Zona)))
                                       (Concatenar (CopiarRegistros Zona)(list "->Push"))))

(define (push2 LocalRepository) (if (null? LocalRepository) null
                                    (Concatenar (push3 (cdar LocalRepository)) (push2 (cdr LocalRepository)))))

(define (push3 CommitAux) (if (null? (cdr CommitAux)) CommitAux
                              (cons (car CommitAux) (push3 (cdr CommitAux)))))


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------