#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto5.c" "Texto6.c" "Texto7.c"))

(define LocalRepository
  (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto3.c" "Texto4.c")))

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
(define (CopiarRemoteRepository ZonaTrabajo) (cadddr ZonaTrabajo))

; Selector Registros
(define (CopiarRegistros ZonaTrabajo) (car (cddddr ZonaTrabajo)))

;Concatenar
(define (Concatenar L1 L2) (if (null? L1) L2
     (cons (car L1) (Concatenar (cdr L1) L2))))
                           
;--------------------------------- Commit --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
(define (commit StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       (commit2 StrCom (cadr Zona) (caddr Zona))
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->Commit"))))

(define (commit2 StrCom Index LocalRepository) (if (null? Index) "No hay archivos para realizar Commit"
                                   (if (null? LocalRepository) (list (Concatenar (list StrCom) Index))
                                       (commit3 StrCom Index LocalRepository))))

(define (commit3 StrCom Index LocalRepository) (if (null? LocalRepository) (list (Concatenar (list StrCom) Index))
                                                   (if (list? LocalRepository) (cons (car LocalRepository) (commit3 StrCom Index (cdr LocalRepository))) null )))


;Despues de esto hay que limpiar index

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
