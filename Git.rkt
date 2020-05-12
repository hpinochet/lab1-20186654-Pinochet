#lang racket

;("Funcion")
(define (pull Zona) 1 )
(define (push Zona) 2 )
(define (add Zona Strings) 3 )
(define (commit Zona Commits) 4 )

(define git (lambda (Comando) (if (or (eq? Comando pull)(eq? Comando push)) (lambda (Zona) (Comando Zona))
                                  (lambda (Zona) (if (or (eq? Comando add) (eq? Comando commit)) (lambda (StrCom) (Comando Zona StrCom))
                                                     ("Favor de Ingresar un Comando Valido"))))))