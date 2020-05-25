#lang racket

(provide zonas->string)

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


;--------------------------------- Display -------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Descripcion: Muestra la Zona de Trabajo.
;Dominio: Zona de Trabajo (ListaxLista).
;Recorrido: Print.
;Tipo de Recursion: Cola.
(define (zonas->string Zona) (list "Zonas de trabajo:" "\n"
        "Workspace: " (CopiarWorkspace Zona) "\n"
        "Index: " (CopiarIndex Zona) "\n"
        "Local Repository: " (CopiarLocalRepository Zona) "\n"
        "Remote Repository: " (CopiarRemoteRepository Zona) "\n"
        "Registros: " (CopiarRegistros Zona) "\n"
        ))

;------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Ej de uso:

; (define Zona(ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros))
; (display (zonas->string Zona))
  