#lang racket

(require "Add.rkt")
(require "Commit.rkt")
(require "Push.rkt")
(require "Pull.rkt")
(require "ZonasString.rkt")
(require "Status.rkt")
(require "Log.rkt")

(define (ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros)
  (list Workspace Index LocalRepository RemoteRepository Registros))

(define Workspace (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt" "Push.rkt" "Pull.rkt"))

(define Index (list ))

(define LocalRepository
  (list ))

(define RemoteRepository
  (list ))

(define Registros
  (list ))

;--------------------------------- Git -------------------------------------------
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

;Zona de trabajo escrita en codigo:

;(define Zona(ZonaTrabajo Workspace Index LocalRepository RemoteRepository Registros))
;(define Zona2 (((git add)null)Zona))
;(define Zona3 (((git commit)"CommitX")Zona2))
;(define Zona4 ((git push)Zona3))
;(define Zona5 ((git pull)Zona4))
;(display((git zonas->string)Zona5))
;(display((git status)Zona))
;(display((git log)Zona))

; Todo en consola:

;Ejemplo 1:
;(define Zona(ZonaTrabajo (list "Texto1.c" "Texto2.c" "Texto3.c" "Texto4.c") (list "Texto1.c" "Texto2.c" "Texto3.c") (list (list "Commit1" "Texto1.c" "Texto2.c") (list "Commit2" "Texto2.c" "Texto4.c") (list "Commit3" "Texto2.c" "Texto4.c")) (list "Texto10.c" "Texto11.c" "Texto12.c" (list (list "Commit10" "Texto10.c") (list "Commit11" "Texto11.c" "Texto12.c"))) (list )))
;(define Zona2 (((git add)null)Zona))
;(define Zona3 (((git commit)"CommitX")Zona2))
;(define Zona4 ((git push)Zona3))
;(define Zona5 ((git pull)Zona4))
;(display((git zonas->string)Zona5))
;(display((git status)Zona))
;(display((git log)Zona))

;Ejemplo 2:
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt") (list ) (list ) (list "Push.rkt" "Pull.rkt"  (list (list "Se agrega Push.rkt" "Push.rkt") (list "Se agrega Pull.rkt" "Pull.rkt"))) (list )))
;(define Zona2 (((git add)(list "Add.rkt" "Commit.rkt"))Zona))
;(define Zona3 (((git commit)"Se agra Add y Commit")Zona2))
;(define Zona4 ((git push)Zona3))
;(define Zona5 ((git pull)Zona4))
;(display((git zonas->string)Zona))
;(display((git status)Zona2))
;(display((git log)Zona5))

;Ejemplo 3:
;(define Zona(ZonaTrabajo (list "ZonaDeTrabajo.rkt" "Add.rkt" "Commit.rkt" "Push.rkt" "Pull.rkt") (list ) (list ) (list ) (list )))
;(define Zona2 (((git add)(list "Add.rkt" "Commit.rkt"))Zona))
;(define Zona3 (((git commit)"Se agra Add y Commit")Zona2))
;(define Zona4 (((git add)(list "Push.rkt" "Pull.rkt"))Zona3))
;(display((git status)Zona4))
;(define Zona5 (((git commit)"Se agrega Push y Pull")Zona4))
;(display((git status)Zona5))
;(define Zona6 ((git push)Zona5))
;(display((git zonas->string)Zona6))
;(define Zona7 ((git pull)Zona6))
;(display((git log)Zona7))