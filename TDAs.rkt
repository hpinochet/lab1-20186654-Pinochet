#lang racket

;Beta

; TDA Zonas de Trabajo
; Como: Listas de listas de Lista
; 1 lista representa las zonas
; 2 lista, cada posicion de esa lista reprenta una zona 0 = Workspace 1 = Index 2 = Local Repository 3 = Remote Repository
; 3 lista, lista con 2 posiciones 0 = "nombre archivo" 1 = "cummit"
; Representacion: Una estructura la cual tenga internamente todas sus zonas de trabajo y sus datos respectivos.
; Constructores: list, cons
; Pertenencias: 
; Selectores: 
; Modificadores:
; Otras operaciones: Add, Commit, Push, Pull

; TDA Workspace
; Como: Lista
; Representacion: Una estructura(lista) la cual almacenara los codigos fuentes (Strings)
; Constructores: 
; Pertenencias: Reconocer Archivo(String)
; Selectores: Copia Archivo (String)
; Modificadores: Editar Archivos(Modificar Strings)
; Otras operaciones: Add(Mover Strings a index proveniente Selector)

; TDA Index
; Como: Lista
; Representacion: Una estructura(lista) donde los cambios son agregados (Strings)
; Constructores: 
; Pertenencias: Reconocer Archivo(String)
; Selectores: 
; Modificadores: Extraer Elementos (strings)
; Otras operaciones: Commit(Mover String a Local Repository)

; TDA Local Repository
; Como: Lista
; Representacion: Una estructura(lista) que almacena los commits generados (Strings) 
; Constructores:
; Pertenencias: Reconocher Archivo(String)
; Selectores: 
; Modificadores: Extaer Elementos (strings)
; Otras operaciones: Push(Mover Strings a Remote Repository)

; TDA Remote Repository
; Como: Lista
; Representacion: Una esctrucutra(lista) que representa un servidor externo que almacena los commits (Strings)
; Constructores: 
; Pertenencias: Reconocer Archivo(String)
; Selectores: Copia Archivo(String)
; Modificadores:
; Otras operaciones: Pull(Mover Strings a Workspace proveniente de Selector)