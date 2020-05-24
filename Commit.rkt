#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto5.c" "Texto6.c"))

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

; Descripcion: Verifica si hay archivos en Index.
; Dominio: StrCom (Archivos ingresados "String") Zona ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola
(define (commit StrCom Zona) (if (null? (CopiarIndex Zona)) "No hay archivos en Index"
                                     (commitx StrCom Zona)))

; Descripcion : Ingresa commit a la Zona de trabajo.
; Dominio : StrCom (Nombre commit "String") y Zona (Zonas de Trabajo "ListaxLista").
; Recorrido : Zonas de trabajo ("ListaxLista).
; Tipo de Recursion: Cola
(define (commitx StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       null
                                       (commit2 StrCom (cadr Zona) (caddr Zona))
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->Commit"))))

; Descripcion : Se ve los casos de Commit (Si existen archivos, Si hay o no Commits hechos).
; Dominio : StrCom (Nombre commit "String"), Index ("Lista") y LocalRepository("lista").
; Recorrido : String o Lista.
; Tipo de Recursion: Cola.
(define (commit2 StrCom Index LocalRepository) (if (null? Index) "No hay archivos para realizar Commit"
                                   (if (null? LocalRepository) (list (Concatenar (list StrCom) Index))
                                       (commit3 StrCom Index LocalRepository))))

; Descripcion : Se apilan los commits
; Dominio : StrCom (Nombre commit "String"), Index ("Lista") y LocalRepository("lista").
; Recorrido : Lista x Lista.
; Tipo de Recursion: Natural.
(define (commit3 StrCom Index LocalRepository) (if (null? LocalRepository) (list (Concatenar (list StrCom) Index))
                                                   (if (list? LocalRepository) (cons (car LocalRepository) (commit3 StrCom Index (cdr LocalRepository)))
                                                       null )))


;Despues de esto hay que limpiar index

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

;Ej de uso:

; (commit "Commitx" Zona)
