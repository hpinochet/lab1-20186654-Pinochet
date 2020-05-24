#lang racket

;Eliminar Duplicados Pendiente

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto4.c" "Texto2.c" "Texto5.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto7.c"))

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
                           

;--------------------------------- Add --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Descripcion: Verifica si hay archivos en Workspace.
; Dominio: StrCom (Archivos ingresados "String") Zona ("ListaxLista").
; Recorrido: String o Accion
; Tipo de Recursion: Cola
(define (add StrCom Zona) (if (null? (CopiarWorkspace Zona)) "No hay archivos en Workspace"
                                     (addX StrCom Zona)))

; Descripcion: Agrega los archivos de Workspace a Index.
; Dominio: StrCom (Archivos ingresados "String") Zona ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola
(define (addX StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (Filtrar (Concatenar (CopiarIndex Zona) (add2 StrCom (car Zona))))
                                       (CopiarLocalRepository Zona)
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->add"))))


; Descripcion: Indica los casos bases, primer caso de add todos los archivos , segundo caso si es lista.
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Lista
; Tipo de Recursion: Cola
(define (add2 StrCom Workspace) (if (null? StrCom) Workspace ; Se agregan todos los archivos
                                    (if (list? StrCom) (EncontrarStrCom1 StrCom Workspace) null ))) ; Se analiza Lista

;Segundo caso de add (Recursion Natural)
; No se debe ingresar dos veces un mismo archivo
; Esta funcion indica si un string esta en workspace y si lo esta lo agrega

; Descripcion: Procedimiento segundo caso add, esta funcion indica si un string esta en workspace y si lo esta lo agrega.
               ;(No se debe ingresar dos veces un mismo archivo).
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Lista
; Tipo de Recursion: Natural
(define (EncontrarStrCom1 StrCom Workspace) (if (null? StrCom) null           ; Termina la lista
                                                (if (EncontrarStrComB (car StrCom) Workspace) (cons (car StrCom)(EncontrarStrCom1 (cdr StrCom) Workspace)) ;Si se encuentra la palabra indicada se agrega
                                                    (cons "Uno de los archivos ingresados es Incorrecto" (EncontrarStrCom1 (cdr StrCom) Workspace))))) ; Se indica que uno de los archivos indicados no se encontro

; Descripcion: Funcion que recorre las listas y muestra si existe la palabra o no.
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (EncontrarStrComB StrCom Workspace) (if (null? Workspace) #false ; No se encontro la palabra.
                                                (if (equal? (car Workspace) StrCom) #true ; Se encontro la palabra.
                                                    (EncontrarStrComB StrCom (cdr Workspace))))) ; Se recorre la lista.

; Descripcion: Funcion que filtra palabras repetidas.
; Dominio: Ind (Lista).
; Recorrido: Ind Filtrado (Lista).
; Tipo de Recursion: Natural.
(define (Filtrar Ind) (if (null? (cdr Ind)) Ind ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Ind) null ; Se termina lista.
                            (if (Agregar Ind (cdr Ind)) (cons (car Ind) (Filtrar (cdr Ind))) ; Si no se repite se agrega.
                                (Filtrar (cdr Ind)))))) ; Se recorre la lista.

; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no)
; Dominio: Ind (Lista) IndAux (Lista)
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (Agregar Ind IndAux) (if (null? IndAux) #true ; No se repite la palabra
                                     (if (equal? (car Ind) (car IndAux)) #false ; Se repite la palabra.
                                         (Agregar Ind (cdr IndAux))))) ; Se recorre la lista


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

;Ej de Usos:

; (add (list "Texto1.c" "Texto2.c" "Texto7.c") Zona);
; (add (list "Texto1.c" "Texto2.c") Zona)
; (add null Zona)