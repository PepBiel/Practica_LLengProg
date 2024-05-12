;**************************************************************
;************************ PRÀCTICA LISP ***********************
;**************************************************************


;********************* INICIALITZACIONS *************************

; FUNCIÓ INICIAL
(defun inici ()
    (inici-objectes)
    (menu)
    (repeteix)
)

; INICIALITZACIÓ D'OBJECTES
(defun inici-objectes ()
    (inici-joc)
    (inici-camp)
    (inici-mur)
    (inici-campesquerre)
    (inici-campdret)
    (inici-canoesquerr)
    (inici-canodret)
    (inici-vent)
    (inici-bandera)
)

(defun inici-joc()
    (putprop 'joc (numero-aleatori 0 1) 'torn)  ; 1 = cano esquerre, 0 = canó dret
    (putprop 'joc 0 'acabat)    ; 0 = no acabat, 1 = acabat
)

; INICIALITZAM CAMP
(defun inici-camp ()
    ; Posam aquests valors perque es vegi la línea del camp, però realment el camp és de 340x640
    (putprop 'camp 339 'altura)
    (putprop 'camp 639 'amplada)
    (putprop 'camp (numero-aleatori 0 40) 'diferencia)
)

; INIZIALITZAM VALORS ALEATORIS PER EL MUR CENTRAL
(defun inici-mur ()
    (putprop 'mur (numero-aleatori 100 150) 'altura)
    (putprop 'mur (numero-aleatori 20 40) 'amplada)
)

; INICIALITZACIÓ DEL CAMP ESQUERRE
(defun inici-campesquerre ()
    (putprop 'campesq (numero-aleatori 15 45) 'altura)
    (putprop 'campesq (generar-campesq) 'amplada)
)

; DETERMINAM L'AMPLADA DEL CAMP ESQUERRE
(defun generar-campesq ()
    ; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li restam la diferència dividida entre 2
    (- (floor (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
        (floor (get 'camp 'diferencia) 2))
)

; INICIALITZACIÓ DEL CAMP DRET
(defun inici-campdret ()
    (putprop 'campdr (numero-aleatori 15 45) 'altura)
    (putprop 'campdr (generar-campdret) 'amplada)
    (putprop 'campdr (+ (get 'campesq 'amplada) (get 'mur 'amplada)) 
        'posicio-campdr)   ; posició exacte d'on comença el camp dret en X (suma del camp esquerre amb el mur)
)
    

; DETERMINAM L'AMPLADA DEL CAMP DRET
(defun generar-campdret ()
    ; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li sumam la diferència dividida entre 2
    ; se pot eliminar ja que per dibuixar no ho utilitzam
    (+ (floor (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
        (floor (get 'camp 'diferencia) 2))
)

; INICIALITZAM EL CANÓ ESQUERRE
(defun inici-canoesquerr ()
    (putprop 'canoesq 10 'altura)
    (putprop 'canoesq 20 'amplada)
    (putprop 'canoesq (numero-aleatori 
           (floor (/ (get 'campesq 'amplada) 3))
           (- (* (floor (/ (get 'campesq 'amplada) 3)) 2) 
           (get 'canoesq 'amplada))) 'posicio)  ; posició en X d'on es troba el canó esquerre
    (putprop 'canoesq 45 'angle)
    (putprop 'canoesq 20 'potencia)
    (putprop 'canoesq 0 'X) ; posició en X de la punta final del canó
    (putprop 'canoesq 0 'Y) ; posició en Y de la punta final del canó
) 

; INICIALITZAM EL CANÓ DRET
(defun inici-canodret ()
    (putprop 'canodr 10 'altura)
    (putprop 'canodr 20 'amplada)
    (putprop 'canodr (numero-aleatori 
           (floor (/ (get 'campdr 'amplada) 3))
           (- (* (floor (/ (get 'campdr 'amplada) 3)) 2) 
           (get 'canodr 'amplada))) 'posicio) ; posició en X d'on es troba el canó dret dintre del seu camp, no és la posició exacte
    (putprop 'canodr (+ (get 'campdr 'posicio-campdr) 
                        (get 'canodr 'posicio)) 'pos-exacte)    ; posició exacte en X d'on es troba el canó dret
    (putprop 'canodr 135 'angle)
    (putprop 'canodr 20 'potencia)
    (putprop 'canodr 0 'X) ; posició en X de la punta final del canó
    (putprop 'canodr 0 'Y) ; posició en Y de la punta final del canó
)

(defun inici-vent ()
    (putprop 'vent (- (numero-aleatori 0 10) 5) 'vent)
)

(defun inici-bandera ()
    (putprop 'bandera (+ (get 'campesq 'amplada) 
                        (floor (/ (get 'mur 'amplada) 2))) 'posicioX)
    (putprop 'bandera (get 'mur 'altura) 'posicioY)
    (putprop 'bandera 20 'pal)
    (putprop 'bandera 20 'amplada)
    (putprop 'bandera 10 'altura)
)

;************************ MENU ************************************

(defun menu()
    (cls)   ; natejam la pantalla
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                          BENVINGUTS AL JOC DELS CANONS")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                            Practica realitzada per:")
    (terpri)
    (terpri)
    (princ "                              Jordi Florit Ensenyat")
    (terpri)
    (terpri)
    (princ "                           Josep Gabriel Fornes Reynes")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                    Pitja qualsevol tecla per iniciar el joc")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (setq tecla (get-key))
)

;************************ INSTRUCCIONS ************************************

(defun instruccions()
    (cls)   ; natejam la pantalla
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                          BENVINGUTS AL JOC DELS CANONS")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                            Practica realitzada per:")
    (terpri)
    (terpri)
    (princ "                              Jordi Florit Ensenyat")
    (terpri)
    (terpri)
    (princ "                           Josep Gabriel Fornes Reynes")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (princ "                    Pitja qualsevol tecla per iniciar el joc")
    (terpri)
    (terpri)
    (terpri)
    (terpri)
    (setq tecla (get-key))
    (cond ((equal tecla 32) ; Pitjam espai
                    (repeteix)) ; incrementa angle cano esquerre i repeteix
            (t                 ; altrament
                (terpri) (instruccions)))
)

;************************ PINTAM ************************************

; FUNCIÓ PRINCIPAL PER PINTAR
(defun pinta ()
    (cls)   ; natejam la pantalla
    (pinta-camp)
    (pinta-mur)
    (pinta-camps)
    (pinta-canons)
    (pinta-pal)
    (pinta-bandera)
)

; PINTAM CAMP PRINCIPAL
(defun pinta-camp()
    (color 81 209 246)
    (rectangle 0 0 (get 'camp 'amplada) (get 'camp 'altura))
)

; PINTA MUR
(defun pinta-mur()
    (color 205 133 63)
    (rectangle (get 'campesq 'amplada) 0 (get 'mur 'amplada)
         (get 'mur 'altura))
)

; CRIDAM A LES FUNCIONS DE PINTAR CAMPS
(defun pinta-camps()
    (color 0 143 57)    ; color verd
    (pinta-campesquerre)
    (pinta-campdret)
)

; PINTAM CAMP ESQUERRE
(defun pinta-campesquerre ()
    (move 0 (get 'campesq 'altura))
    (draw (get 'campesq 'amplada) (get 'campesq 'altura))
)

; PINTAM CAMP DRET
(defun pinta-campdret ()
    (move (+ (get 'mur 'amplada) (get 'campesq 'amplada)) 
        (get 'campdr 'altura))
    (draw (get 'camp 'amplada) (get 'campdr 'altura))
)

; CRIDAM A LES FUNCIONS PER PINTAR CANONS
(defun pinta-canons()
    (color 0 0 0)   ; color  negre
    (pinta-canoesquerre)
    (pinta-canodret)
)

; PINTAM CANÓ ESQUERRE
(defun pinta-canoesquerre ()
    (rectangle (get 'canoesq 'posicio) (get 'campesq 'altura) 
        (get 'canoesq 'amplada) (get 'canoesq 'altura))
    (angle (+ (get 'canoesq 'posicio) (floor (get 'canoesq 'amplada) 2)) 
        (+ (get 'campesq 'altura) (get 'canoesq 'altura)) 
        (get 'canoesq 'potencia) (get 'canoesq 'angle) 1)
)

; PINTAM CANÓ DRET
(defun pinta-canodret ()
    (rectangle (+ (get 'canodr 'posicio) 
        (+ (get 'campesq 'amplada) (get 'mur 'amplada))) 
        (get 'campdr 'altura) (get 'canodr 'amplada) 
        (get 'canodr 'altura))
    (angle (+ (+ (get 'canodr 'posicio) (floor (get 'canodr 'amplada) 2)) 
        (+ (get 'campesq 'amplada) (get 'mur 'amplada))) 
        (+ (get 'campdr 'altura) (get 'canodr 'altura)) 
        (get 'canodr 'potencia) (get 'canodr 'angle) 0)
)

(defun pinta-pal ()
    (move (get 'bandera 'posicioX) (get 'bandera 'posicioY))
    (draw (get 'bandera 'posicioX) (+ (get 'bandera 'posicioY) 
                                    (get 'bandera 'pal)))
)

(defun pinta-bandera()
    (cond
        ((= (get 'vent 'vent) 0) ; Si el vent és 0
            )

        ((< (get 'vent 'vent) 0) ; Si es vent és negatiu
            (secciona-bandera (- (get 'vent 'vent) 1) 
                                    (get 'bandera 'posicioX) 
                                    (+ (get 'bandera 'posicioY) 
                                        (/ (get 'bandera 'pal) 2))))
            
        (t                          ; si el vent és positiu
            (secciona-bandera (+ (get 'vent 'vent) 1)
                                    (get 'bandera 'posicioX) 
                                    (+ (get 'bandera 'posicioY) 
                                        (/ (get 'bandera 'pal) 2))))
    )
    
)

(defun secciona-bandera (n x y)
    (cond ((= n 0) nil)
            ((> n 0) 
                (rectangle x y 5 10)
                (secciona-bandera (- n 1) (+ x 5) y))
            (t 
                (rectangle x y (- 5) 10)
                (secciona-bandera (+ n 1) (- x 5) y))
    
    )
)

; PINTAM UN RECTANGLE
; dibuixam un rectangle en la posició (x, y), amb altura h i amplada w
(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h))
)


;************************ NOMBRE ALEATORI ************************************

(defun numero-aleatori (minim maxim)
    (+ minim (random (+ 1 (- maxim minim))))
)

;************************ REPETICIÓ ************************************

(defun repeteix ()
    (cond ((= (get 'joc 'acabat) 0)
                (pinta)
                (cond ((= (get 'joc 'torn) 0)   ; torn cano dret 
                            (princ "Es el torn del cano dret. "))  
                        (t (princ "Es el torn del cano esquerre. "))   ; torn cano esquerre 
                )
                (princ "Pitja ESC per sortir o ")
                (princ "Espai per veure les instruccions")
                (terpri)
                (setq tecla (get-key))
                        ; CANO ESQUERRE
                (cond ((equal tecla 119) ; Pitjam w
                            (inc-angle-canons 1) (repeteix)) ; incrementa angle cano esquerre i repeteix
                        ((equal tecla 115) ; Pitja s
                            (dec-angle-canons 1) (repeteix)) ; decrementa angle cano esquerre i repeteix
                        ((equal tecla 102) ; Pitja f
                            (cond ((= (get 'joc 'torn) 1)
                                        (dispara-canons 1))   ; dispara canó esquerre 
                                    (t (format t "No és el teu torn")
                                        (terpri)
                                        (sleep 2)
                                        (repeteix))
                            )) 
                        ((equal tecla 101) ; Pitja e
                            (aug-potencia-canons 1) (repeteix)) ; incrementam potència canó esquerre
                        ((equal tecla 113) ; Pitja q
                            (dis-potencia-canons 1) (repeteix)) ; decrementam potència canó esquerre
                        ((equal tecla 97) ; Pitja a
                            (moure-esquerre-canons 1) (repeteix)) ; movem canó esquerre cap esquerre
                        ((equal tecla 100) ; Pitja d
                            (moure-dreta-canons 1) (repeteix)) ; movem canó esquerre cap dreta
                        
                        ; CANO DRETA
                        ((equal tecla 105) ; Pitja i
                            (inc-angle-canons 0) (repeteix)) ; incrementa angle cano dret i repeteix
                        ((equal tecla 107) ; Pitja k
                            (dec-angle-canons 0) (repeteix)) ; decrementa angle cano dret i repeteix
                        ((equal tecla 104) ; Pitja h
                            (cond ((= (get 'joc 'torn) 0)
                                        (dispara-canons 0))  ; dispara canó dret 
                                    (t (format t "No és el teu torn")
                                        (terpri)
                                        (sleep 2)
                                        (repeteix))
                            ))
                        ((equal tecla 117) ; Pitja u
                            (aug-potencia-canons 0) (repeteix)) ; incrementam potència canó dret
                        ((equal tecla 111) ; Pitja o
                            (dis-potencia-canons 0) (repeteix)) ; decrementam potència canó dret
                        ((equal tecla 106) ; Pitja j
                            (moure-esquerre-canons 0) (repeteix)) ; movem canó esquerre cap dret
                        ((equal tecla 108) ; Pitja l
                            (moure-dreta-canons 0) (repeteix)) ; movem canó dret cap dreta

                        ; INSTRUCCIONS
                        ((equal tecla 32)  ; ESPAI
                            (instruccions))

                        ; ACABA EL JOC
                        ((equal tecla 27)  ; ESC
                            "Gràcies per jugar")    ; acaba la recursió
                            
                        ; TECLA NO RECONEGUDA
                        (t                 ; altrament
                            (repeteix))))           ; repeteix
            (t "Gràcies per jugar")))


; *************************** ACCIONS TECLES *********************************

; cano = 1 -> conó esquerre
; cano = 0 -> conó dret

; INCREMENTAM ANGLE CANONS
(defun inc-angle-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; s'agafa l'angle guardat, se li suma 1 i es guarda el nou valor
            (putprop 'canoesq (+ (get 'canoesq 'angle) 1) 'angle))

        ((= cano 0) ; Si es el cano dret
            ; s'agafa l'angle guardat, se li suma 1 i es guarda el nou valor
            (putprop 'canodr (- (get 'canodr 'angle) 1) 'angle))
        (t
            (format t "Cano no reconegut."))
    )
)

; DECREMENTAM ANGLE CANONS
(defun dec-angle-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; s'agafa l'angle guardat, se li resta 1 i es guarda el nou valor
            (putprop 'canoesq (- (get 'canoesq 'angle) 1) 'angle))

        ((= cano 0) ; Si es el cano dret
            ; s'agafa l'angle guardat, se li resta 1 i es guarda el nou valor
            (putprop 'canodr (+ (get 'canodr 'angle) 1) 'angle))
        (t
            (format t "Cano no reconegut."))
    )
)

; AUGMENTAM POTÈNCIA CANONS
(defun aug-potencia-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; s'agafa la potència guardada, se li suma 1 i es guarda el nou valor
            (putprop 'canoesq (+ (get 'canoesq 'potencia) 1) 'potencia))

        ((= cano 0) ; Si es el cano dret
            ; s'agafa la potència guardada, se li suma 1 i es guarda el nou valor
            (putprop 'canodr (+ (get 'canodr 'potencia) 1) 'potencia))
        (t
            (format t "Cano no reconegut."))
    )
)

; DISMINUIM POTÈNCIA CANONS
(defun dis-potencia-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; s'agafa la potència guardada, se li resta 1 i es guarda el nou valor
            (putprop 'canoesq (- (get 'canoesq 'potencia) 1) 'potencia))

        ((= cano 0) ; Si es el cano dret
            ; s'agafa la potència guardada, se li resta 1 i es guarda el nou valor
            (putprop 'canodr (- (get 'canodr 'potencia) 1) 'potencia))
        (t
            (format t "Cano no reconegut."))
    )
)

; MOVEM CANONS A LA ESQUERRE
(defun moure-esquerre-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; si el cano una posició menys es troba dintre del camp esquerre, es podrà moure
            (cond ((and (> (- (get 'canoesq 'posicio) 1) 0))
                (putprop 'canoesq (- (get 'canoesq 'posicio) 1) 'posicio))
            ))

        ((= cano 0) ; Si es el cano dret
            ; si el cano una posició menys es troba dintre del camp dret, es podrà moure
            (cond ((and (> (- (get 'canodr 'pos-exacte) 1) 
                (get 'campdr 'posicio-campdr)))
                    (putprop 'canodr (- (get 'canodr 'pos-exacte) 1) 
                        'pos-exacte)
                    (putprop 'canodr (- (get 'canodr 'posicio) 1) 
                        'posicio))
            ))
        (t
            (format t "Cano no reconegut."))
    )
)

; MOVEM CANONS A LA DRETA
(defun moure-dreta-canons (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; si el cano una posició més es troba dintre del camp esquerre, es podrà moure
            (cond ((and (< (+ (+ (get 'canoesq 'posicio) 
                    (get 'canoesq 'amplada)) 1) (get 'campesq 'amplada)))
                            (putprop 'canoesq (+ (get 'canoesq 'posicio) 1) 
                                'posicio))))

        ((= cano 0) ; Si es el cano dret
            ; si el cano una posició més es troba dintre del camp dret, es podrà moure
            (cond ((and (< (+ (+ (get 'canodr 'pos-exacte) 
                    (get 'canoesq 'amplada)) 1) (get 'camp 'amplada)))
                            (putprop 'canodr (+ (get 'canodr 'pos-exacte) 1) 
                                'pos-exacte)
                            (putprop 'canodr (+ (get 'canodr 'posicio) 1) 
                                'posicio))))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun angle (x y r angle mode)
  (cond
    ((= mode 1) ; Si es el cano esquerre
        (move x y)
        (putprop 'canoesq (+ x (* r (cos (radians angle)))) 'X)
        (putprop 'canoesq (+ y (* r (sin (radians angle)))) 'Y)
        (drawr (get 'canoesq 'X) (get 'canoesq 'Y)))

    ((= mode 0) ; Si es el cano dret
        (move x y)
        (putprop 'canodr (+ x (* r (cos (radians angle)))) 'X)
        (putprop 'canodr (+ y (* r (sin (radians angle)))) 'Y)
        (drawr (get 'canodr 'X) (get 'canodr 'Y)))
    (t
     (format t "Cano no reconegut."))
  ))

(defun radians (graus)
  (/ (* graus (* 2 pi)) 360))

(defun drawr (x y)
  "pinta a les coordenades arrodonides"
  (draw (round x) 
        (round y)))

;1. vix i viy (velocitats inicials) NO RECURSIU
;2. Entrar bucle recursiu 
;3. Calcula -> velocitats (depen de les anteriors) i posicions (depen de les anteriors)
;4. Dibuixa -> segons posicions bala
;5. Mirar aturada -> si no colisiona tornar a 2 si coliona sortir.
(defun dispara-canons (cano)
    ;(move (round (get 'canoesq 'X)) (round (get 'canodr 'X)))
    (ini-bala cano)
    (bucle cano)
    (dibuixar-bolla cano))

(defun bucle (cano)
    (calcular cano)
    (dibuixar cano)
    (aturada cano)
)

(defun calcular (cano)
    (sleep 0.0001)
    (calc-vel cano)
    (calc-pos cano)
    (inc-temps cano)
)

(defun dibuixar (cano)
    (color 255 0 0)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((= (get 'bala-esq 'trajectoria) 0)
                (mover (get 'bala-esq 'X) (get 'bala-esq 'Y))
                (putprop 'bala-esq 1 'trajectoria))
            ((= (get 'bala-esq 'trajectoria) 1)
                (drawr (get 'bala-esq 'X) (get 'bala-esq 'Y))
                (putprop 'bala-esq 0 'trajectoria))))

        ((= cano 0) ; Si es el cano dret
            (cond ((= (get 'bala-dr 'trajectoria) 0)
                (mover (get 'bala-dr 'X) (get 'bala-dr 'Y))
                (putprop 'bala-dr 1 'trajectoria))
            ((= (get 'bala-dr 'trajectoria) 1)
                (drawr (get 'bala-dr 'X) (get 'bala-dr 'Y))
                (putprop 'bala-dr 0 'trajectoria))))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun dibuixar-bolla (cano)
    (color 255 0 0)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cercle (get 'bala-esq 'X) (get 'bala-esq 'Y) 
                (get 'bala-esq 'radi) 100)
            (esperar-entrada))

        ((= cano 0) ; Si es el cano dret
            (cercle (get 'bala-dr 'X) (get 'bala-dr 'Y) 
                (get 'bala-dr 'radi) 100)
            (esperar-entrada))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun esperar-entrada ()
    (cond ((= (get 'joc 'acabat) 0)
                (format t "Pitja la tecla espai per continuar")
                (setq tecla (get-key))
                (cond ((equal tecla 32) ; Pitjam espai
                                (cond ((= (get 'joc 'torn) 0)   ; torn cano dret 
                                            (putprop 'joc 1 'torn))  
                                        (t (putprop 'joc 0 'torn))   ; torn cano esquerre 
                                )
                                (repeteix)) ; incrementa angle cano esquerre i repeteix
                        (t                 ; altrament
                        (terpri) (esperar-entrada))))
            (t (repeteix)))
)

(defun cercle (x y radi segments)
    (mover (+ x radi) y)
    (cercle2 x y radi (/ 360 segments) 0))

(defun cercle2 (x y radi pas angle)
  (cond ((< angle 360)
         (drawr (+ x (* radi (cos (radians (+ angle pas)))))
                (+ y (* radi (sin (radians (+ angle pas))))))
         (cercle2 x y radi pas (+ angle pas)))
        (t t)))

(defun mover (x y)
  "mou a les coordenades arrodonides"
  (move (round x) 
        (round y)))

(defun drawr (x y)
  "pinta a les coordenades arrodonides"
  (draw (round x) 
        (round y)))

(defun aturada (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (colisio-canodret cano))

        ((= cano 0) ; Si es el cano dret
            (colisio-canoesquerre cano))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun colisio-canodret (cano)
    (cond ((and (>= (get 'bala-esq 'X) (get 'canodr 'pos-exacte))
            (<= (get 'bala-esq 'X) (+ (get 'canodr 'pos-exacte) 
                    (get 'canodr 'amplada))))
                (cond ((and (>= (get 'bala-esq 'Y) (get 'campdr 'altura)) 
                            (<= (get 'bala-esq 'Y) (+ (get 'campdr 'altura) 
                                (get 'canodr 'altura))))
                                (putprop 'joc 1 'acabat)
                                (format t "Victoria del cano esquerre")
                                (terpri))
                            (t (colisio-campdret cano))))
        (t (colisio-campdret cano)))
)

(defun colisio-canoesquerre (cano)
    (cond ((and (>= (get 'bala-dr 'X) (get 'canoesq 'posicio))
            (<= (get 'bala-dr 'X) (+ (get 'canoesq 'posicio) 
                    (get 'canoesq 'amplada))))
                (cond ((and (>= (get 'bala-dr 'Y) (get 'campesq 'altura)) 
                            (<= (get 'bala-dr 'Y) (+ (get 'campesq 'altura) 
                                (get 'canoesq 'altura))))
                                (putprop 'joc 1 'acabat)
                                (format t "Victoria del cano dret")
                                (terpri))
                            (t (colisio-campdret cano))))
        (t (colisio-campdret cano)))
)

(defun colisio-campdret (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((and (> (get 'bala-esq 'X) (get 'campdr 'posicio-campdr)) 
                        (< (get 'bala-esq 'Y) (get 'campdr 'altura))))
            (t (colisio-mur cano))))

        ((= cano 0) ; Si es el cano dret
            (cond ((and (> (get 'bala-dr 'X) (get 'campdr 'posicio-campdr)) 
                        (< (get 'bala-dr 'Y) (get 'campdr 'altura))))
            (t (colisio-mur cano))))
        (t
            (format t "Cano no reconegut."))
    ) 
)

(defun colisio-mur (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((and (>= (get 'bala-esq 'X) (get 'campesq 'amplada))
                        (<= (get 'bala-esq 'X) 
                            (get 'campdr 'posicio-campdr)))
                                (cond ((<= (get 'bala-esq 'Y) 
                                    (get 'mur 'altura)))
                                        (t (bucle cano))))
                    (t (colisio-campesq cano))))

        ((= cano 0) ; Si es el cano dret
            (cond ((and (>= (get 'bala-dr 'X) (get 'campesq 'amplada))
                        (<= (get 'bala-dr 'X) 
                            (get 'campdr 'posicio-campdr)))
                                (cond ((<= (get 'bala-dr 'Y) 
                                    (get 'mur 'altura)))
                                        (t (bucle cano))))
                    (t (colisio-campesq cano))))
        (t
            (format t "Cano no reconegut."))
    ) 
)

(defun colisio-campesq (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((and (< (get 'bala-esq 'X) (get 'campesq 'amplada)) 
                            (< (get 'bala-esq 'Y) (get 'campesq 'altura))))
                    (t (colisio-limits cano))))

        ((= cano 0) ; Si es el cano dret
            (cond ((and (< (get 'bala-dr 'X) (get 'campesq 'amplada)) 
                            (< (get 'bala-dr 'Y) (get 'campesq 'altura))))
                    (t (colisio-limits cano))))
        (t
            (format t "Cano no reconegut."))
    ) 
)

(defun colisio-limits (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((or (< (get 'bala-esq 'X) 0) 
                    (or (> (get 'bala-esq 'Y) (get 'camp 'altura))
                        (> (get 'bala-esq 'X) (get 'camp 'amplada)))))
                (t (bucle cano))))

        ((= cano 0) ; Si es el cano dret
            (cond ((or (< (get 'bala-dr 'X) 0) 
                    (or (> (get 'bala-dr 'Y) (get 'camp 'altura))
                        (> (get 'bala-dr 'X) (get 'camp 'amplada)))))
                (t (bucle cano))))
        (t
            (format t "Cano no reconegut."))
    ) 
)

(defun inc-temps (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (putprop 'bala-esq 
                (+ (get 'bala-esq 'temps) 0.0005) 'temps))

        ((= cano 0) ; Si es el cano dret
            (putprop 'bala-dr 
                (+ (get 'bala-dr 'temps) 0.0005) 'temps))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun ini-bala (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (putprop 'bala-esq (* (get 'canoesq 'potencia) 
                (cos (* (get 'canoesq 'angle) (/ pi 180)))) 'vix)

            (putprop 'bala-esq (* (get 'canoesq 'potencia) 
                (sin (* (get 'canoesq 'angle) (/ pi 180)))) 'viy)
                
            (putprop 'bala-esq -9.8 'acceleracio)
            (putprop 'bala-esq 0 'temps)
            (putprop 'bala-esq (get 'canoesq 'X) 'X) ;punta vector x
            (putprop 'bala-esq (get 'canoesq 'Y) 'Y) ;punta vecetor y
            (putprop 'bala-esq 5 'radi)
            (putprop 'bala-esq 0 'trajectoria)
            (mover (get 'bala-esq 'X) (get 'bala-esq 'Y)))

        ((= cano 0) ; Si es el cano dret
            (putprop 'bala-dr (* (get 'canodr 'potencia) 
                (cos (* (get 'canodr 'angle) (/ pi 180)))) 'vix)

            (putprop 'bala-dr (* (get 'canodr 'potencia) 
                (sin (* (get 'canodr 'angle) (/ pi 180)))) 'viy)
                
            (putprop 'bala-dr -9.8 'acceleracio)
            (putprop 'bala-dr 0 'temps)
            (putprop 'bala-dr (get 'canodr 'X) 'X) ;punta vector x
            (putprop 'bala-dr (get 'canodr 'Y) 'Y) ;punta vecetor y
            (putprop 'bala-dr 5 'radi)
            (putprop 'bala-dr 0 'trajectoria)
            (mover (get 'bala-dr 'X) (get 'bala-dr 'Y)))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun calc-vel (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (putprop 'bala-esq (calc-velx cano) 'vix)
            (putprop 'bala-esq (calc-vely cano) 'viy))

        ((= cano 0) ; Si es el cano dret
            (putprop 'bala-dr (calc-velx cano) 'vix)
            (putprop 'bala-dr (calc-vely cano) 'viy))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun calc-velx (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'vix) (* (get 'vent 'vent) 
                (get 'bala-esq 'temps))))

        ((= cano 0) ; Si es el cano dret
            (+ (get 'bala-esq 'vix) (* (get 'vent 'vent) 
                (get 'bala-dr 'temps))))
        (t
            (format t "Cano no reconegut."))
    )
)
    
; falta cano dret
(defun calc-vely (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'viy) (* (get 'bala-esq 'acceleracio) 
            (get 'bala-esq 'temps))))

        ((= cano 0) ; Si es el cano dret
            (+ (get 'bala-dr 'viy) (* (get 'bala-dr 'acceleracio) 
            (get 'bala-dr 'temps))))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun calc-pos (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (putprop 'bala-esq (calc-posx cano) 'X)
            (putprop 'bala-esq (calc-posy cano) 'Y))

        ((= cano 0) ; Si es el cano dret
            (putprop 'bala-dr (calc-posx cano) 'X)
            (putprop 'bala-dr (calc-posy cano) 'Y))
        (t
            (format t "Cano no reconegut."))
    )
)

; falta cano dret
(defun calc-posx (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'X) (* (get 'bala-esq 'vix) 
            (get 'bala-esq 'temps))))

        ((= cano 0) ; Si es el cano dret
            (- (get 'bala-dr 'X) (* (get 'bala-dr 'vix) 
            (get 'bala-dr 'temps))))
        (t
            (format t "Cano no reconegut."))
    )
)

; falta cano dret
(defun calc-posy (cano)
    
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'Y) (* (get 'bala-esq 'viy) 
                (get 'bala-esq 'temps)) 
            (* 0.5 (get 'bala-esq 'acceleracio) 
                (* (get 'bala-esq 'temps) (get 'bala-esq 'temps)))))

        ((= cano 0) ; Si es el cano dret
            (+ (get 'bala-dr 'Y) (* (get 'bala-dr 'viy) 
                (get 'bala-dr 'temps)) 
            (* 0.5 (get 'bala-dr 'acceleracio) 
                (* (get 'bala-dr 'temps) (get 'bala-dr 'temps)))))
        (t
            (format t "Cano no reconegut."))
    )
)

(defun sleep (seconds)
    "Espera la quantitat indicada de segons"
    ; Això és un bucle iteratiu. NO PODEU FER-NE SERVIR ENLLOC MÉS
    (do ((endtime (+ (get-internal-real-time)
    (* seconds internal-time-units-per-second))))
    ((> (get-internal-real-time) endtime))))

(inici)
