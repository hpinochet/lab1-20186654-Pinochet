#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list (list"Commit" "Texto1.c" "Texto2.c") (list"Commit2" "Texto3.c" "Texto4.c")))

(define RemoteRepository
  (list  "Texto3.c" "Texto4.c" "Texto2.c" "texto7.c" (list (list "Commit" "Texto3.c" "Texto4.c") (list "Commit5" "Texto7.c"))))

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


(define (zonas->string Zona) (list "Zonas de trabajo:" "\n"
        "Workspace: " (CopiarWorkspace Zona) "\n"
        "Index: " (CopiarIndex Zona) "\n"
        "Local Repository: " (CopiarLocalRepository Zona) "\n"
        "Remote Repository: " (CopiarRemoteRepository Zona) "\n"
        "Registros: " (CopiarRegistros Zona) "\n"
        ))

;Ej de uso:

; (define Zona(ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros))
; (display (zonas->string Zona))
  