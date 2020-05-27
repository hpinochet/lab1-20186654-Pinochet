#lang racket

(provide status)

; Selectores

; Selector Index
(define (CopiarIndex ZonaTrabajo) (cadr ZonaTrabajo))

; Selector LocalRepository
(define (CopiarLocalRepository ZonaTrabajo) (caddr ZonaTrabajo))

;--------------------------------- Status ------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Descripcion: Muestra los archivos que hay en index, la cantidad de commits y la rama actual.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Print.
;Tipo de Recursion: Cola.
(define (status Zona) (list "Estado: 
        Archivos en Index: " (CopiarIndex Zona) "
        Cantidad de Commits: " (length (CopiarLocalRepository Zona)) "
        Rama Actual: master \n"))

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Ej de uso:

;(display(Status Zona))
;Solo se puede usar en ZonaDeTrabajo.rkt