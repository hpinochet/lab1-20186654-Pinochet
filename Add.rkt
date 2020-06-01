#lang racket

;Se envian funciones
(provide add)

;Descripcion: Se define estructura ZonaTrabajo.
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

;--------------------------------- Add --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

; Funcion Constructor.
; Descripcion: Verifica si hay archivos en Workspace.
; Dominio: StrCom (Archivos ingresados "String") Zona ("ListaxLista").
; Recorrido: String o Accion.
; Tipo de Recursion: Cola.
(define (add StrCom Zona) (if (null? (CopiarWorkspace Zona)) "No hay archivos en Workspace"
                                     (addX StrCom Zona)))

; Descripcion: Agrega los archivos de Workspace a Index.
; Dominio: StrCom (Archivos ingresados "String") Zona ("ListaxLista").
; Recorrido: Zona de Trabajo (ListaxLista).
; Tipo de Recursion: Cola.
(define (addX StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (FiltrarAdd (Concatenar (CopiarIndex Zona) (add2 StrCom (car Zona))))
                                       (CopiarLocalRepository Zona)
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->add"))))


; Descripcion: Indica los casos bases, primer caso de add todos los archivos , segundo caso si es lista.
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Lista.
; Tipo de Recursion: Cola.
(define (add2 StrCom Workspace) (if (null? StrCom) Workspace ; Se agregan todos los archivos
                                    (if (list? StrCom) (EncontrarStrCom1 StrCom Workspace) null ))) ; Se analiza Lista

; Segundo caso de add (Recursion Natural).
; Esta funcion indica si un string esta en workspace y si lo esta lo agrega.

; Descripcion: Procedimiento segundo caso add, esta funcion indica si un string esta en workspace y si lo esta lo agrega.
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Lista.
; Tipo de Recursion: Natural.
(define (EncontrarStrCom1 StrCom Workspace) (if (null? StrCom) null           ; Termina la lista
                                                (if (EncontrarStrComB (car StrCom) Workspace) (cons (car StrCom)(EncontrarStrCom1 (cdr StrCom) Workspace)) ;Si se encuentra la palabra indicada se agrega
                                                    (cons "Uno de los archivos ingresados es Incorrecto" (EncontrarStrCom1 (cdr StrCom) Workspace))))) ; Se indica que uno de los archivos indicados no se encontro

; Funcion Pertenencia.
; Descripcion: Recorre las listas y indica si existe la palabra o no.
; Dominio: StrCom (Archivos ingresados "String") Workspace ("Lista").
; Recorrido: Booleano.
; Tipo de Recursion: Cola.
(define (EncontrarStrComB StrCom Workspace) (if (null? Workspace) #false ; No se encontro la palabra.
                                                (if (equal? (car Workspace) StrCom) #true ; Se encontro la palabra.
                                                    (EncontrarStrComB StrCom (cdr Workspace))))) ; Se recorre la lista.

; Descripcion: Funcion que filtra palabras repetidas.
; Dominio: Ind (Lista).
; Recorrido: Ind Filtrado (Lista).
; Tipo de Recursion: Natural.
(define (FiltrarAdd Ind) (if (null? (cdr Ind)) Ind ;Solo es una palabra no se filtra o es la ultima palabra.
                            (if (null? Ind) null ; Se termina lista.
                            (if (AgregarAdd Ind (cdr Ind)) (cons (car Ind) (FiltrarAdd (cdr Ind))) ; Si no se repite se agrega.
                                (FiltrarAdd (cdr Ind)))))) ; Se recorre la lista.

; Funcion Pertenencia
; Descripcion: Indica si la palabra debe ser ingresada o no (Si se repite no)
; Dominio: Ind (Lista) IndAux (Lista)
; Recorrido: Booleano
; Tipo de Recursion: Cola
(define (AgregarAdd Ind IndAux) (if (null? IndAux) #true ; No se repite la palabra
                                     (if (equal? (car Ind) (car IndAux)) #false ; Se repite la palabra.
                                         (AgregarAdd Ind (cdr IndAux))))) ; Se recorre la lista


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------