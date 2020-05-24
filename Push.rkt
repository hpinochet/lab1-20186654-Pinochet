#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c")))

(define RemoteRepository
  (list "Texto10.c" "Texto11.c" "Texto12.c" "Texto13.c" (list (list "Commit10" "Texto3.c" "Texto4.c") (list "Commit11" "Texto5.c" "Texto6.c") )))

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

; Descripcion: Verifica si hay archivos en Local Repository.
; Dominio: Zona ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola
(define (push Zona) (if (null? LocalRepository) "Local Repository esta vacio" (if (null? (CopiarRemoteRepository Zona)) (pushXX Zona)
                        (pushX Zona))))

; Descripcion: Agrega los archivos de LocalRepository a RemoteRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola
; Nota: Esta funcion automaticamente deja los commits recientemente ingresados al principio, para poder asi favorecer el trabajo de la funcion log.
(define (pushX Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       null
                                       (Concatenar (Filtrar (Concatenar (CopiarRemoteArchivos (CopiarRemoteRepository Zona)) (pushcase (caddr Zona)))) (list (Concatenar (CopiarLocalCommits (CopiarLocalRepository Zona)) (CopiarRemoteCommits (CopiarRemoteRepository Zona)))))
                                       (Concatenar (CopiarRegistros Zona)(list "->Push"))))


; Descripcion: Agrega los archivos de LocalRepository a RemoteRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola.
(define (pushXX Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (CopiarIndex Zona)
                                       null
                                       (Concatenar (Filtrar (pushcase (caddr Zona))) (CopiarLocalCommits (CopiarLocalRepository Zona)) )
                                       (Concatenar (CopiarRegistros Zona)(list "->Push"))))


; Descripcion: Verifica si Local Repository posee o no Commits.
; Dominio: LocalRepository (Lista).
; Recorrido: Lista o Accion.
; Tipo de Recursion: Cola.
(define (pushcase LocalRepository) (if (null? LocalRepository) (list "Local Repository esta vacio")
                                       (push2 LocalRepository)))

; Descripcion: Funcion que extrae los archivos de los commits
; Dominio: LocalRepository (Lista)
; Recorrido: Lista
; Tipo de Recursion: Natural
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


; Descripcion: Una puesta la cabeza de la lista en los commits se guardan.
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
(define (Filtrar Remote) (if (null? (cdr Remote)) Remote ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Remote) null ; Se termina lista.
                            (if (Agregar Remote (cdr Remote)) (cons (car Remote) (Filtrar (cdr Remote))) ; Si no se repite se agrega.
                                (Filtrar (cdr Remote)))))) ; Se recorre la lista.


; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no)
; Dominio: Remote (Lista) RemoteAux (Lista)
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (Agregar Remote RemoteAux) (if (null? RemoteAux) #true ; No se repite la palabra
                                     (if (equal? (car Remote) (car RemoteAux)) #false ; Se repite la palabra.
                                         (Agregar Remote (cdr RemoteAux))))) ; Se recorre la lista


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------