#lang racket

;Se envian funcion
(provide zonas->string)

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


;--------------------------------- ZonasString -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Descripcion: Muestra la Zona de Trabajo.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Print.
;Tipo de Recursion: Cola.
(define (zonas->string Zona) (string-append "Zonas de trabajo:" "\n\n"
        "Workspace:\nContiene los siguientes archivos: " (CopiarWorkspace2 (CopiarWorkspace Zona)) "\n\n"
        "Index:\nContiene los siguientes archivos: " (CopiarIndex2 (CopiarIndex Zona)) "\n\n"
        "LocalRepository:\nContiene los siguientes commits: " (CopiarLocalRepository2 (CopiarLocalRepository Zona)) "\n\n"
        "RemoteRepository: \n"
        (CopiarRemoteRepository2 (CopiarRemoteRepository Zona))
        "\n\nRegistro de Comandos: " (CopiarRegistros2 (CopiarRegistros Zona)) "\n\n"
        ))

;--------------------------------------------- Workspace -----------------------------------------

; Descripcion: Crea string con los archivos de Workspace.
; Dominio: Workspace (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (CopiarWorkspace2 Workspace) (if (null? Workspace) "Workspace no tiene archivos."
                                         ( if (null? (cdr Workspace)) (car Workspace)
                                                (string-append (car Workspace) " " (CopiarWorkspace2 (cdr Workspace))))))

;--------------------------------------------- Index -----------------------------------------

; Descripcion: Crea string con los archivos de Index.
; Dominio: Index (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (CopiarIndex2 Index) (if (null? Index) "Index no tiene archivos."
                                 (if (null? (cdr Index)) (car Index)
                                        (string-append (car Index) " " (CopiarIndex2 (cdr Index))))))


;--------------------------------------------- Local Repository -----------------------------------------

; Descripcion: Crea string con los commits de Local Repository.
; Dominio: LocalRepository (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (CopiarLocalRepository2 Commits) (if (null? Commits) "Local Repository no posee commits."
                                             (if (null? (cdr Commits)) (string-append "\n - (" (ArchivosCommit (car Commits)) ")")
                                                    (string-append "\n - " (string-append "(" (ArchivosCommit (car Commits))")" (CopiarLocalRepository2 (cdr Commits)))))))

; Descripcion: Convierte en string el contenido de los commits.
; Dominio: Commit (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (ArchivosCommit Commit) (if (null? (cdr Commit)) (car Commit)
                                                (string-append (car Commit) " " (ArchivosCommit (cdr Commit)))))

;--------------------------------------------- Remote Reposiotry -----------------------------------------

; Descripcion: Crea string con los archivos y commits de Remote Repository.
; Dominio: RemoteReposiotry (ListaxLista).
; Recorrido: String.
; Tipo de Recursion: Cola. 
(define (CopiarRemoteRepository2 RemoteRepository) (if (null? RemoteRepository) "Remote Repository no posee ni archivos ni commits."
                                                       (string-append "Contiene los siguientes archivos: "(CopiarRemoteArchivosZonas RemoteRepository) "\n" 
                                                                      "Contiene los siguientes commits: " (CopiarLocalRepository2 (CopiarRemoteCommitsZonas RemoteRepository)))))
; Descripcion: 
; Dominio: 
; Recorrido: 
; Tipo de Recursion: 
(define (CopiarRemoteArchivosZonas RemoteRepository) (if (list? (car RemoteRepository)) " "
                                                    (string-append (car RemoteRepository) " " (CopiarRemoteArchivosZonas (cdr RemoteRepository)))))


; Descripcion: Copia los Commit de Remote Repository (En esta funcion en especifico se mueve en la lista hasta encontrar los commits)
; Dominio: RemoteRepository (Lista).
; Recorrido: Accion
; Tipo de Recursion: Cola
(define (CopiarRemoteCommitsZonas RemoteRepository) (if (list? (car RemoteRepository)) (car RemoteRepository)
                                                    (CopiarRemoteCommitsZonas (cdr RemoteRepository))))


; Descripcion: Una vez puesta la cabeza de la lista en los commits se guardan.
; Dominio: RemoteRepository (Lista).
; Recorrido: Lista de commits (Lista).
; Tipo de Recursion: Natural.
(define (CopiarCommitsZonas RemoteRepository) (if (null? RemoteRepository) null
                                                    (cons (car RemoteRepository) (CopiarCommitsZonas (cdr RemoteRepository)))))

;--------------------------------------------- Registros -----------------------------------------

; Descripcion: Crea string con los comandos de Registros.
; Dominio: Registros (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural. 
(define (CopiarRegistros2 Registros) (if (null? Registros) "No se han ejecutado comandos"
                                         (if (null? (cdr Registros)) (car Registros)
                                                (string-append (car Registros) " " (CopiarRegistros2 (cdr Registros))))))

;------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------