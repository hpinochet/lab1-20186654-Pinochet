#lang racket

;Se solicitan funciones a los archivos.
(require "Add.rkt")
(require "Commit.rkt")
(require "Push.rkt")
(require "Pull.rkt")
(require "ZonasString.rkt")
(require "Status.rkt")
(require "Log.rkt")

;Descripcion: Se define estructura ZonaTrabajo.
;Dominio: Workspace (Lista), Index (Lista), LocalRepository (ListaxLista), RemoteRepository (ListaxLista) y Registros (Lista).
;Recorrido: ListaxLista.
;Tipo de Recursion: Cola.
(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
  (list Workspace Index LocalRepository RemoteRepository Registros))

;--------------------------------- Git --------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Descripcion: LLamado de funciones.
;Dominio: Comando(Funcion) ,Zona (ListaxLista) y StrCom(String).
;Recorrido: Funcion.
;Tipo de Recursion: Cola.
(define git (lambda (Comando) (if (or (eq? Comando pull)(eq? Comando push)(eq? Comando status)(eq? Comando log)(eq? Comando zonas->string)) (lambda (Zona) (Comando Zona))
                                  (lambda (Zona) (if (or (eq? Comando add) (eq? Comando commit)) (lambda (StrCom) (Comando Zona StrCom))
                                                     ("Favor de Ingresar un Comando Valido"))))))


;Ej de uso:

; Todo en consola:

;Ejemplo 1:
;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c") (list "Commit3" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(define Zona2 (((git add)null)Zona))
;(define Zona3 (((git commit)"CommitX")Zona2))
;(define Zona4 ((git push)Zona3))
;(define Zona5 ((git pull)Zona4))
;(display((git zonas->string)Zona5))
;(display((git status)Zona5))
;(display((git log)Zona5))
;(define Zona6 (((git add)(list "Texto1.c" "Texto3.c"))Zona5))
;(define Zona7 (((git commit)"CommitXX")Zona6))
;(define Zona8 ((git push)Zona7))
;(define Zona9 ((git pull)Zona8))
;(display((git zonas->string)Zona9))
;(display((git status)Zona6))
;(display((git log)Zona9))

;Ejemplo 2:
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt") (list ) (list ) (list "Push.rkt" "Pull.rkt"  (list (list "Se agrega Push.rkt" "Push.rkt") (list "Se agrega Pull.rkt" "Pull.rkt"))) (list )))
;(define Zona2 (((git add)(list "Add.rkt" "Commit2.rkt"))Zona)) 
;(display((git zonas->string)Zona2))
;(define Zona2 (((git add)(list "Add.rkt" "Commit.rkt"))Zona)) ;Ejemplo como arreglar error
;(display((git zonas->string)Zona2))
;(define Zona3 (((git commit)"Se agra Add y Commit")Zona2))
;(define Zona4 ((git push)Zona3))
;(define Zona5 ((git pull)Zona4))
;(display((git zonas->string)Zona5))
;(display((git status)Zona2))
;(display((git log)Zona5))

;Ejemplo 3:
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt" "Push.rkt" "Pull.rkt") (list ) (list ) (list ) (list )))
;(define Zona2 (((git add)(list "Add.rkt" "Commit.rkt"))Zona))
;(define Zona3 (((git commit)"Se agrega Add y Commit")Zona2))
;(define Zona4 (((git add)(list "Push.rkt" "Pull.rkt"))Zona3))
;(display((git status)Zona4))
;(define Zona5 (((git commit)"Se agrega Push y Pull")Zona4))
;(display((git status)Zona5))
;(define Zona6 ((git push)Zona5))
;(display((git zonas->string)Zona6))
;(define Zona7 ((git pull)Zona6))
;(display((git log)Zona7))

; Si no se va a guiar por los codigos de ejemplo recuerde que:
; - Debe seguir con la linealidad de Zonas: Zona -> Zona1 -> Zona2 -> Zona3 -> ....
; - En el add si se equivoca en ingresar los archivos llame a la misma funcion cambiando el archivo.
;   Ej:
;        (define Zona2 (((git add)(list "Add.rkt" "Commit2.rkt"))Zona)) // Me equivoco 
;        (define Zona2 (((git add)(list "Add.rkt" "Commit.rkt"))Zona))  // Lo redefino
;   Debido a esto siempre ir ejecutando (display((git zonas->string)Zona)) para ir verificando si esta trabajando bien.
;  - Si el usuario ejecuta un comando el cual no tiene los prerrequisitos,
;    deberá realizar de nuevo el comando. (Por ejemplo, se haga un Add y no hay
;    archivos en Workspace). Si llegara a realizar zonas->string ocurriría un
;    error a nivel de código debido a que esta función trabaja en base a Zonas
;    y si ocurre el error Zonas estaría conformado por un string. Ej: (“Workspace esta vacio”).