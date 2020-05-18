#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list ))

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
                                       (commit2 StrCom (cadr Zona))
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->Commit"))))

(define (commit2 StrCom Index) (if (null? Index) "No hay archivos para realizar Commit" (Concatenar (list StrCom) Index)))
;Despues de esto hay que limpiar index

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
