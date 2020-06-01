#lang racket

;Se envian funcion
(provide status)

; Selectores

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

;--------------------------------- Status ------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Descripcion: Muestra los archivos que hay en index, la cantidad de commits y la rama actual.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Print.
;Tipo de Recursion: Cola.
(define (status Zona) (string-append "\nEstado: \n\n" 
        "Archivos en Index: " (CopiarIndex2 (CopiarIndex Zona)) "\n"
        "Cantidad de Commits: " (number->string(length (CopiarLocalRepository Zona))) "\n"
        "Rama Actual: Master \n\n"))

; Descripcion: Crea string con los archivos de Index.
; Dominio: Index (Lista).
; Recorrido: String.
; Tipo de Recursion: Natural.
(define (CopiarIndex2 Index) (if (null? Index) "Index no tiene archivos"
                                 (if (null? (cdr Index)) (car Index)
                                        (string-append (car Index) " " (CopiarIndex2 (cdr Index))))))

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------