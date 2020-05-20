#lang racket

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
                      (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace
  (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c")
 )

(define Index
  (list "Texto1.c" "Texto2.c" "Texto3.c"))

(define LocalRepository
  (list "Commit" "Texto1.c" "Texto2.c"))

(define RemoteRepository
  (list "Texto1.c" "Texto2.c" "Texto321.c" (list "Commit" "Texto1.c" "Texto2.c" "Texto321.c")))

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


(define (zonas->string ZonaTrabajo)
        (display (list
        "Zonas de trabajo:
        \nWorkspace: " (CopiarWorkspace ZonaTrabajo)
        "\nIndex: " (CopiarIndex ZonaTrabajo) 
        "\nLocal Repository: " (CopiarLocalRepository ZonaTrabajo)
        "\nRemote Repository: " (CopiarRemoteRepository ZonaTrabajo)
        "\nRegistros: " (CopiarRegistros ZonaTrabajo))))
  