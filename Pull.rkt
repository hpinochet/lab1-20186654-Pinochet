#lang racket

;Eliminar Duplicados

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto2.c" "Texto10.c" "Texto3.c" "Texto5.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list (list"Commit" "Texto1.c" "Texto2.c")))

(define RemoteRepository
  (list "Texto3.c" "Texto4.c" "Texto2.c" "texto7.c" (list (list "Commit" "Texto3.c" "Texto4.c") (list "Commit5" "Texto7.c"))))

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
(define (pullX Zona) (ZonaTrabajo (Filtrar (pull2 (CopiarRemoteRepository Zona) (CopiarWorkspace Zona)))
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
(define (Filtrar Works) (if (null? (cdr Works)) Works ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Works) null ; Se termina lista.
                            (if (Agregar Works (cdr Works)) (cons (car Works) (Filtrar (cdr Works))) ; Si no se repite se agrega.
                                (Filtrar (cdr Works)))))) ; Se recorre la lista.

; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no)
; Dominio: Works (Lista) WorksAux (Lista)
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (Agregar Works WorksAux) (if (null? WorksAux) #true ; No se repite la palabra
                                     (if (equal? (car Works) (car WorksAux)) #false ; Se repite la palabra.
                                         (Agregar Works (cdr WorksAux))))) ; Se recorre la lista

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------