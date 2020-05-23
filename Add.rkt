#lang racket

;Eliminar Duplicados Pendiente

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c"))

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
(define (add StrCom Zona) (ZonaTrabajo (CopiarWorkspace Zona)
                                       (Concatenar (CopiarIndex Zona) (add2 StrCom (car Zona)))
                                       (CopiarLocalRepository Zona)
                                       (CopiarRemoteRepository Zona)
                                       (Concatenar (CopiarRegistros Zona)(list "->add"))))


; Primer caso de add (Solo un archivo o todos los archivos)
(define (add2 StrCom Workspace) (if (null? StrCom) Workspace (if (string? StrCom) (EncontrarStrCom1 StrCom Workspace)
                                    (if (list? StrCom) (EncontrarStrCom2 StrCom Workspace) null ))))


(define (EncontrarStrCom1 StrCom Workspace) (if (null? Workspace) "El archivo no existe"
                                                (if (equal? (car Workspace) StrCom) (list StrCom)
                                                    (EncontrarStrCom1 StrCom (cdr Workspace)))))


;Segundo caso de add (Recursion Natural)
; No se debe ingresar dos veces un mismo archivo
; Esta funcion muestra si un string esta en workspace
(define (EncontrarStrCom2 StrCom Workspace) (if (null? StrCom) null
                                                (if (EncontrarStrComB (car StrCom) Workspace) (cons (car StrCom)(EncontrarStrCom2 (cdr StrCom) Workspace))
                                                    "Uno de los archivos ingresados es Incorrecto")))

(define (EncontrarStrComB StrCom Workspace) (if (null? Workspace) #false
                                                (if (equal? (car Workspace) StrCom) #true
                                                    (EncontrarStrComB StrCom (cdr Workspace)))))


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

