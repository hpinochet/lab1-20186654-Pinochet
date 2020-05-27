#lang racket

(provide pull)
(provide pullX)
(provide pull2)
(provide FiltrarPull)
(provide AgregarPull)

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

;--------------------------------- Pull -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Descripcion: Verifica si Existen archivos en remote repository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola
(define (pull Zona) (if (null? (CopiarRemoteRepository Zona)) "El remote Repository esta vacio"
                        (pullX Zona)))

; Descripcion: Agrega los archivos de RemoteRepository a LocalRepository.
; Dominio: Zona de Trabajo ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola
(define (pullX Zona) (ZonaTrabajo (FiltrarPull (pull2 (CopiarRemoteRepository Zona) (CopiarWorkspace Zona)))
                                 (CopiarIndex Zona)
                                 (CopiarLocalRepository Zona)
                                 (CopiarRemoteRepository Zona)
                                 (Concatenar (CopiarRegistros Zona)(list "->Pull"))))

; Descripcion: Se concatena lista con los archivo dentro de remote repository
; Dominio: RemoteRepository (Lista) y Listaux (Lista vacia) 
; Recorrido: Lista
; Tipo de Recursion: Cola
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

; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no)
; Dominio: Works (Lista) WorksAux (Lista)
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (AgregarPull Works WorksAux) (if (null? WorksAux) #true ; No se repite la palabra
                                     (if (equal? (car Works) (car WorksAux)) #false ; Se repite la palabra.
                                         (AgregarPull Works (cdr WorksAux))))) ; Se recorre la lista

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

;Ej de uso:
;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c") (list "Commit3" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt") (list ) (list ) (list "Push.rkt" "Pull.rkt"  (list (list "Se agrega Push.rkt" "Push.rkt") (list "Se agrega Pull.rkt" "Pull.rkt"))) (list )))
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt" "Push.rkt" "Pull.rkt") (list ) (list ) (list "Texto1.c" "Texto2.c" "Texto3.c" (list (list "Commit1" "Texto1.c") (list "Commit2" "Texto2.c" "Texto3.c"))) (list )))
;(pull Zona)