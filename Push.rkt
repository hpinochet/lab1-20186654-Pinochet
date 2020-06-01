#lang racket

;Se envian funciones
(provide push)

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

;--------------------------------- Push --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Funcion Constructor.
; Descripcion: Verifica si hay archivos en Local Repository.
; Dominio: Zona ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola.
(define (push Zona) (if (null? (CopiarLocalRepository Zona)) "Local Repository esta vacio" (if (null? (CopiarRemoteRepository Zona)) (pushXX Zona)
                        (pushX Zona))))

; Descripcion: Agrega los archivos de LocalRepository a RemoteRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola.
(define (pushX Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       (CopiarLocalRepository Zona)
                                       (Concatenar (FiltrarPush (Concatenar (CopiarRemoteArchivos (CopiarRemoteRepository Zona)) (pushcase (caddr Zona)))) (list (FiltrarPush(Concatenar (CopiarLocalCommits (CopiarLocalRepository Zona)) (CopiarRemoteCommits (CopiarRemoteRepository Zona))))))
                                       (Concatenar (CopiarRegistros Zona)(list "->Push"))))


; Descripcion: Agrega los archivos de LocalRepository a RemoteRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola.
(define (pushXX Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       (CopiarLocalRepository Zona)
                                       (Concatenar (FiltrarPush (pushcase (caddr Zona))) (list(CopiarLocalCommits (CopiarLocalRepository Zona))))
                                       (Concatenar (CopiarRegistros Zona)(list "->Push"))))


; Descripcion: Verifica si Local Repository posee o no Commits.
; Dominio: LocalRepository (Lista).
; Recorrido: Lista o Accion.
; Tipo de Recursion: Cola.
(define (pushcase LocalRepository) (if (null? LocalRepository) (list "Local Repository esta vacio")
                                       (push2 LocalRepository)))

; Descripcion: Funcion que extrae los archivos de los commits.
; Dominio: LocalRepository (Lista).
; Recorrido: Lista.
; Tipo de Recursion: Natural.
(define (push2 LocalRepository) (if (null? LocalRepository) null ; El Local repository esta vacio
                                    (Concatenar (push3 (cdar LocalRepository)) (push2 (cdr LocalRepository))))) ; Concatena archivos

; Descripcion: Crea lista de archivos de cada commit.
; Dominio: Commit
; Recorrido: Lista
; Tipo de Recursion: Natural 
(define (push3 CommitAux) (if (null? (cdr CommitAux)) CommitAux ; LLega al final de la lista.
                              (cons (car CommitAux) (push3 (cdr CommitAux))))) ; Concatena los archivos.


; Descripcion: Copia los archivos de Remote Repository.
; Dominio: RemoteRepository (Lista).
; Recorrido: Archivos de RemoteRepository (Lista).
; Tipo de Recursion: Natural.
(define (CopiarRemoteArchivos RemoteRepository) (if (list? (car RemoteRepository)) null
                                                    (cons (car RemoteRepository) (CopiarRemoteArchivos (cdr RemoteRepository)))))


; Descripcion: Copia los Commit de Remote Repository (En esta funcion en especifico se mueve en la lista hasta encontrar los commits)
; Dominio: RemoteRepository (Lista).
; Recorrido: Accion
; Tipo de Recursion: Cola
(define (CopiarRemoteCommits RemoteRepository) (if (list? (car RemoteRepository)) (car RemoteRepository)
                                                    (CopiarRemoteCommits (cdr RemoteRepository))))


; Descripcion: Una vez puesta la cabeza de la lista en los commits se guardan.
; Dominio: RemoteRepository (Lista).
; Recorrido: Lista de commits (Lista).
; Tipo de Recursion: Natural.
(define (CopiarCommits RemoteRepository) (if (null? RemoteRepository) null
                                                    (cons (car RemoteRepository) (CopiarCommits (cdr RemoteRepository)))))

; Descripcion: Copia los commits de Local Repository.
; Dominio: LocalRepository (Lista).
; Recorrido: Lista de commits (Lista).
; Tipo de Recursion: Natural.
(define (CopiarLocalCommits LocalRepository) (if (null? LocalRepository) null
                                                 (cons (car LocalRepository) (CopiarLocalCommits (cdr LocalRepository)))))

; Descripcion: Funcion que filtra palabras repetidas.
; Dominio: Remote (Lista).
; Recorrido: Remote Filtrado (Lista).
; Tipo de Recursion: Natural.
(define (FiltrarPush Remote) (if (null? (cdr Remote)) Remote ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Remote) null ; Se termina lista.
                            (if (AgregarPush Remote (cdr Remote)) (cons (car Remote) (FiltrarPush (cdr Remote))) ; Si no se repite se agrega.
                                (FiltrarPush (cdr Remote)))))) ; Se recorre la lista.

; Funcion Pertenencia.
; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no).
; Dominio: Remote (Lista) RemoteAux (Lista).
; Recorrido: Booleano.
; Tipo de Recursion: Cola.
(define (AgregarPush Remote RemoteAux) (if (null? RemoteAux) #true ; No se repite la palabra
                                     (if (equal? (car Remote) (car RemoteAux)) #false ; Se repite la palabra.
                                         (AgregarPush Remote (cdr RemoteAux))))) ; Se recorre la lista


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

;Ej de Uso:

;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c") (list "Commit3" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Modificacion1" "Texto1.c") (list "Modificacion2" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Entrega1" "Add.rkt") (list "Entrega2" "Commit.rkt" "Pull.rkt") (list "Entrega3" "Push.rkt" "Zonas.rkt" "Status.rkt" "Log.rkt")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(push Zona)