#lang racket

;Se envian funciones
(provide pull)

;Descripcion: se define estructura ZonaTrabajo.
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

;--------------------------------- Pull -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Funcion Constructor.
; Descripcion: Verifica si Existen archivos en remote repository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola
(define (pull Zona) (if (null? (CopiarRemoteRepository Zona)) "El remote Repository esta vacio"
                        (pullX Zona)))

; Descripcion: Agrega los archivos de RemoteRepository a LocalRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola.
(define (pullX Zona) (ZonaTrabajo (FiltrarPull (pull2 (CopiarRemoteRepository Zona) (CopiarWorkspace Zona)))
                                 (CopiarIndex Zona)
                                 (CopiarLocalRepository Zona)
                                 (CopiarRemoteRepository Zona)
                                 (Concatenar (CopiarRegistros Zona)(list "->Pull"))))

; Descripcion: Se concatena lista con los archivo dentro de remote repository.
; Dominio: RemoteRepository (Lista) y Listaux (Lista vacia).
; Recorrido: Lista.
; Tipo de Recursion: Cola.
(define (pull2 RemoteRepository Workspace) (if (list? (car RemoteRepository)) Workspace 
                                     (pull2 (cdr RemoteRepository) (Concatenar Workspace (list (car RemoteRepository))))))

; Descripcion: Funcion que filtra palabras repetidas.
; Dominio: Works (Lista).
; Recorrido: Works Filtrado (Lista).
; Tipo de Recursion: Natural.
(define (FiltrarPull Works) (if (null? (cdr Works)) Works ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Works) null ; Se termina lista.
                            (if (AgregarPull Works (cdr Works)) (cons (car Works) (FiltrarPull (cdr Works))) ; Si no se repite se agrega.
                                (FiltrarPull (cdr Works)))))) ; Se recorre la lista.

; Funcion Pertenencia
; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no).
; Dominio: Works (Lista) WorksAux (Lista).
; Recorrido: Booleano.
; Tipo de Recursion: Cola.
(define (AgregarPull Works WorksAux) (if (null? WorksAux) #true ; No se repite la palabra
                                     (if (equal? (car Works) (car WorksAux)) #false ; Se repite la palabra.
                                         (AgregarPull Works (cdr WorksAux))))) ; Se recorre la lista

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------