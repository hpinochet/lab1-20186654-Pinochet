#lang racket

;Se envian funciones
(provide commit)

;Descripcion: Se Define estructura ZonaTrabajo.
;Dominio: Workspace (Lista), Index (Lista), LocalRepository (ListaxLista), RemoteRepository (ListaxLista) y Registros (Lista).
;Recorrido: ListaxLista.
;Tipo de Recursion: Cola.
(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

; Selectores

; Selector Workspace
; Descripcion: Copia la informacion de Workspace.
; Dominio: ZonaTrabajo(ListaxLista).
; Recorrido: Workspace.
; Tipo de Recursion: Cola.
(define (CopiarWorkspace ZonaTrabajo) (car ZonaTrabajo))

; Selector Index
; Descripcion: Copia la informacion de Index.
; Dominio: ZonaTrabajo(ListaxLista).
; Recorrido: Index
; Tipo de Recursion: Cola. 
(define (CopiarIndex ZonaTrabajo) (cadr ZonaTrabajo))

; Selector LocalRepository
; Descripcion: Copiar la Informacion de Local Repository,
; Dominio: ZonaTrabajo(ListaxLista)
; Recorrido: Local Repository.
; Tipo de Recursion: Cola.
(define (CopiarLocalRepository ZonaTrabajo) (caddr ZonaTrabajo))

; Selector RemoteRepository
; Descripcion: Copiar la Informacion de Remote Reposiotry.
; Dominio: ZonaTrabajo(ListaxLista).
; Recorrido: Remote Repository.
; Tipo de Recursion: Cola.
(define (CopiarRemoteRepository ZonaTrabajo) (cadddr ZonaTrabajo))

; Selector Registros
; Descripcion: Copiar la Informacion de Registros.
; Dominio: ZonaTrabajo(ListaxLista).
; Recorrido: Registros.
; Tipo de Recursion: Cola.
(define (CopiarRegistros ZonaTrabajo) (car (cddddr ZonaTrabajo)))

; Concatenar
; Descripcion: Conacatena dos listas.
; Dominio: Dos Listas.
; Recorrido: Una Lista.
; Tipo de Recursion: Natural. 
(define (Concatenar Lista1 Lista2) (if (null? Lista1) Lista2
     (cons (car Lista1) (Concatenar (cdr Lista1) Lista2))))

;--------------------------------- Commit --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Funcion Constructor
; Descripcion: Verifica si hay archivos en Index.
; Dominio: StrCom (Nombre Commit "String") Zona ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola.
(define (commit StrCom Zona) (if (null? (CopiarIndex Zona)) "No hay archivos en Index"
                                     (commitx StrCom Zona)))

; Descripcion : Ingresa commit a la Zona de trabajo.
; Dominio : StrCom (Nombre commit "String") y Zona (Zonas de Trabajo "ListaxLista").
; Recorrido : Zonas de trabajo ("ListaxLista).
; Tipo de Recursion: Cola.
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

; Descripcion : Se apilan los commits.
; Dominio : StrCom (Nombre commit "String"), Index ("Lista") y LocalRepository("lista").
; Recorrido : Lista x Lista.
; Tipo de Recursion: Natural.
(define (commit3 StrCom Index LocalRepository) (if (null? LocalRepository) null
                                                   (if (list? LocalRepository) (cons (car LocalRepository) (commit3 StrCom Index (cdr LocalRepository)))
                                                       null )))

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------