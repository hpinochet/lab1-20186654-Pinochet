#lang racket

(provide commit)
(provide commitx)
(provide commit2)
(provide commit3)

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

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
(define (Concatenar Lista1 Lista2) (if (null? Lista1) Lista2
     (cons (car Lista1) (Concatenar (cdr Lista1) Lista2))))

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
; Nota: Se agregan los commits al inicio para facilitar el trabajo de log.
(define (commitx StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       null
                                       (Concatenar (list (Concatenar (list StrCom) (CopiarIndex Zona))) (commit2 StrCom (cadr Zona) (caddr Zona)))
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->Commit"))))

; Descripcion : Se ve los casos de Commit (Si existen archivos, Si hay o no Commits hechos).
; Dominio : StrCom (Nombre commit "String"), Index ("Lista") y LocalRepository("lista").
; Recorrido : String o Lista.
; Tipo de Recursion: Cola.
(define (commit2 StrCom Index LocalRepository) (if (null? Index) "No hay archivos para realizar Commit"
                                   (if (null? LocalRepository) null
                                       (commit3 StrCom Index LocalRepository))))

; Descripcion : Se apilan los commits
; Dominio : StrCom (Nombre commit "String"), Index ("Lista") y LocalRepository("lista").
; Recorrido : Lista x Lista.
; Tipo de Recursion: Natural.
(define (commit3 StrCom Index LocalRepository) (if (null? LocalRepository) null
                                                   (if (list? LocalRepository) (cons (car LocalRepository) (commit3 StrCom Index (cdr LocalRepository)))
                                                       null )))

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

;Ej de uso:

;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c") (list "Commit3" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(commit "Commit1" Zona)
;(commit "Se agregaron los archivos .." Zona)
;(commit "Se modifico el archivo .." Zona)