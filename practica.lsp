;************************ PRÀCTICA LISP ***********************

;********************* INICIALITZACIONS *************************

; FUNCIÓ INICIAL
(defun inici ()
    (inici-objectes)
    (repeteix))

; INICIALITZACIÓ D'OBJECTES
(defun inici-objectes ()
    (inici-camp)
    (inici-mur)
    (inici-campesquerre)
    (inici-campdret)
    (inici-canoesquerr)
    (inici-canodret)
)

; INICIALITZAM CAMP
(defun inici-camp ()
    ; Posam aquests valors perque es vegi la línea del camp, però realment el camp és de 340x640
    (putprop 'camp 339 'altura)
    (putprop 'camp 639 'amplada)
    (putprop 'camp (numero-aleatori 0 40) 'diferencia))

; INIZIALITZAM VALORS ALEATORIS PER EL MUR CENTRAL
(defun inici-mur ()
    (putprop 'mur (numero-aleatori 100 150) 'altura)
    (putprop 'mur (numero-aleatori 20 40) 'amplada))

; INICIALITZACIÓ DEL CAMP ESQUERRE
(defun inici-campesquerre ()
    (putprop 'campesq (numero-aleatori 15 45) 'altura)
    (putprop 'campesq (generar-campesq) 'amplada))

; DETERMINAM L'AMPLADA DEL CAMP ESQUERRE
(defun generar-campesq ()
    ; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li restam la diferència dividida entre 2
    (- (floor (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
        (floor (get 'camp 'diferencia) 2)))

; INICIALITZACIÓ DEL CAMP DRET
(defun inici-campdret ()
    (putprop 'campdr (numero-aleatori 15 45) 'altura)
    (putprop 'campdr (generar-campdret) 'amplada))

; DETERMINAM L'AMPLADA DEL CAMP DRET
; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li sumam la diferència dividida entre 2
; se pot eliminar ja que per dibuixar no ho utilitzam
(defun generar-campdret ()
    (+ (floor (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
        (floor (get 'camp 'diferencia) 2)))

; INICIALITZAM EL CANÓ ESQUERRE
(defun inici-canoesquerr ()
    (putprop 'canoesq 10 'altura)
    (putprop 'canoesq 20 'amplada)
    (putprop 'canoesq (numero-aleatori 
           (floor (/ (get 'campesq 'amplada) 3))
           (- (* (floor (/ (get 'campesq 'amplada) 3)) 2) 
           (get 'canoesq 'amplada))) 'posicio)
    (putprop 'canoesq 45 'angle)
    (putprop 'canoesq 20 'potencia)
    (putprop 'canoesq 0 'X) ; posició en X de la punta final del canó
    (putprop 'canoesq 0 'Y)) ; posició en Y de la punta final del canó

; INICIALITZAM EL CANÓ DRET
(defun inici-canodret ()
    (putprop 'canodr 10 'altura)
    (putprop 'canodr 20 'amplada)
    (putprop 'canodr (numero-aleatori 
           (floor (/ (get 'campdr 'amplada) 3))
           (- (* (floor (/ (get 'campdr 'amplada) 3)) 2) 
           (get 'canodr 'amplada))) 'posicio)
    (putprop 'canodr 135 'angle)
    (putprop 'canodr 20 'potencia)
    (putprop 'canodr 0 'X)
    (putprop 'canodr 0 'Y))

;************************ PINTAM ************************************

; FUNCIÓ PRINCIPAL PER PINTAR
(defun pinta ()
    (cls)   ; natejam la pantalla
    (pinta-camp)
    (pinta-mur)
    (pinta-camps)
    (pinta-canons)
)

; PINTAM CAMP PRINCIPAL
(defun pinta-camp()
    (color 0 0 0)
    (rectangle 0 0 (get 'camp 'amplada) (get 'camp 'altura))
)

; PINTA MUR
(defun pinta-mur()
    (color 205 133 63)
    (rectangle (get 'campesq 'amplada) 0 (get 'mur 'amplada)
         (get 'mur 'altura)))

; CRIDAM A LES FUNCIONS DE PINTAR CAMPS
(defun pinta-camps()
    (color 0 143 57)    ; color verd
    (pinta-campesquerre)
    (pinta-campdret))

; PINTAM CAMP ESQUERRE
(defun pinta-campesquerre ()
    (move 0 (get 'campesq 'altura))
    (draw (get 'campesq 'amplada) (get 'campesq 'altura)))

; PINTAM CAMP DRET
(defun pinta-campdret ()
    (move (+ (get 'mur 'amplada) (get 'campesq 'amplada)) 
        (get 'campdr 'altura))
    (draw (get 'camp 'amplada) (get 'campdr 'altura)))

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
        (get 'canoesq 'potencia) (get 'canoesq 'angle) 1))

; PINTAM CANÓ DRET
(defun pinta-canodret ()
    (rectangle (+ (get 'canodr 'posicio) 
        (+ (get 'campesq 'amplada) (get 'mur 'amplada))) 
        (get 'campdr 'altura) (get 'canodr 'amplada) 
        (get 'canodr 'altura))
    (angle (+ (+ (get 'canodr 'posicio) (floor (get 'canodr 'amplada) 2)) 
        (+ (get 'campesq 'amplada) (get 'mur 'amplada))) 
        (+ (get 'campdr 'altura) (get 'canodr 'altura)) 
        (get 'canodr 'potencia) (get 'canodr 'angle) 0))

(defun repeteix ()
    (pinta)
    (princ "Pitja fletxa cap amunt o cap avall o ESC.")
    (terpri)
    (setq tecla (get-key))
    (cond ((equal tecla 119) ; Pitjam w
                (inc-angle-canoesq) (repeteix)) ; incrementa angle cano esquerre i repeteix
            ((equal tecla 115) ; Pitja s
                (dec-angle-canoesq) (repeteix)) ; decrementa angle cano esquerre i repeteix
            ((equal tecla 105) ; Pitja i
                (inc-angle-canodr) (repeteix)) ; incrementa angle cano dret i repeteix
            ((equal tecla 107) ; Pitja k
                (dec-angle-canodr) (repeteix)) ; decrementa angle cano dret i repeteix
            ((equal tecla 102) ; Pitja f
                (dispara-cano) (repeteix)) ; dispara canó esquerre
            ((equal tecla 101) ; Pitja e
                (aug-potencia) (repeteix)) ; incrementam potència canó esquerre
            ((equal tecla 113) ; Pitja q
                (dis-potencia) (repeteix)) ; decrementam potència canó esquerre
            ((equal tecla 97) ; Pitja a
                (moure-esquerre) (repeteix)) ; movem canó esquerre cap esquerre
            ((equal tecla 100) ; Pitja d
                (moure-dreta) (repeteix)) ; movem canó esquerre cap dreta
          ((equal tecla 27)  ; ESC
           "Gràcies per jugar")                      ; acaba recursió
          (t                 ; altrament
           (repeteix))))           ; repeteix

(defun repeteix-cano-esq ()
    (pinta-canons)
    (setq tecla (get-key))
    (cond ((equal tecla 119) ; fletxa cap amunt
           (inc-angle-canoesq) (repeteix-cano-esq)) ; incrementa angle i repeteix
          ((equal tecla 115) ; fletxa cap avall
           (dec-angle-canoesq) (repeteix-cano-esq)) ; decrementa angle i repeteix
          ((equal tecla 27)  ; ESC
           "Gràcies per jugar")                      ; acaba recursió
          (t                 ; altrament
           (repeteix))))           ; repeteix

(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h)))

(defun numero-aleatori (minim maxim)
    (+ minim (random (+ 1 (- maxim minim)))))

(defun inc-angle-canoesq ()
    "incrementa l'angle"
    (print (get 'canoesq 'angle))
    (putprop 'canoesq (+ (get 'canoesq 'angle) 1) 'angle))

(defun dec-angle-canoesq ()
    "decrementa l'angle"
    (putprop 'canoesq (- (get 'canoesq 'angle) 1) 'angle))

(defun inc-angle-canodr ()
    "decrementa l'angle"
    (putprop 'canodr (- (get 'canodr 'angle) 1) 'angle))

(defun dec-angle-canodr ()
    "incrementa l'angle"
    (putprop 'canodr (+ (get 'canodr 'angle) 1) 'angle))

(defun aug-potencia ()
    "incrementa l'angle"
    (putprop 'canoesq (+ (get 'canoesq 'potencia) 1) 'potencia))

(defun dis-potencia ()
    "incrementa l'angle"
    (putprop 'canoesq (- (get 'canoesq 'potencia) 1) 'potencia))

(defun moure-esquerre ()
    (cond ((and (> (- (get 'canoesq 'posicio) 1) 0))
         (putprop 'canoesq (- (get 'canoesq 'posicio) 1) 'posicio)) ; Hacer algo si el valor está dentro del rango
        ))

(defun moure-dreta()
    (cond ((and (< (+ (+ (get 'canoesq 'posicio) (get 'canoesq 'amplada)) 1) 
                        (get 'campesq 'amplada)))
         (putprop 'canoesq (+ (get 'canoesq 'posicio) 1) 'posicio)))) ; Hacer algo si el valor está dentro del rango
        

;(defun angle (x y r angle)
;    (move x y)
;    (drawr (+ x (* r (cos (radians angle))))
;           (+ y (* r (sin (radians angle))))))

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
     (format t "Modo no reconocido."))
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
(defun dispara-cano ()
    (ini-bala)
    (bucle))

(defun bucle ()
    (calcular)
    (dibuixar)
    (aturada)
)

(defun calcular ()
    ;(trace calc-vel)
    ;(untrace calc-vel)
    (calc-vel)
    (calc-pos)
    (inc-temps)
)

(defun dibuixar ()
    (cercle (get 'bala 'X) (get 'bala 'Y) 
        (get 'bala 'radi) 100)
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

(defun aturada ()
    (bucle) ;DE MOMENT NO S'ATURA
)

(defun inc-temps ()
    (putprop 'bala (+ (get 'bala 'temps) 0.1) 'temps)
)

(defun ini-bala ()
    (putprop 'bala (* (get 'canoesq 'potencia) 
        (cos (* (get 'canoesq 'angle) (/ pi 180)))) 'vix)

    (putprop 'bala (* (get 'canoesq 'potencia) 
        (sin (* (get 'canoesq 'angle) (/ pi 180)))) 'viy)
        
    (putprop 'bala -9.8 'acceleracio)
    (putprop 'bala 0 'temps)
    (putprop 'bala (get 'canoesq 'X) 'X) ;punta vector x
    (putprop 'bala (get 'canoesq 'Y) 'Y) ;punta vecetor y
    (putprop 'bala 5 'radi)
)

(defun calc-vel ()
    ;(print (get 'bala 'vix))
    (putprop 'bala (get 'bala 'vix) 'vix)
    ;(print (calc-vely))
    (putprop 'bala (calc-vely) 'viy)
)
    

(defun calc-vely ()
    (+ (get 'bala 'viy) (* (get 'bala 'acceleracio) 
    (get 'bala 'temps)))
)

(defun calc-pos ()
    (putprop 'bala (calc-posx) 'X)
    (putprop 'bala (calc-posy) 'Y)
)

(defun calc-posx ()
    (+ (get 'bala 'X) (* (get 'bala 'vix) 
    (get 'bala 'temps)))
)

(defun calc-posy ()
    (+ (get 'bala 'Y) (* (get 'bala 'viy) 
        (get 'bala 'temps)) 
    (* 0.5 (get 'bala 'acceleracio) 
        (* (get 'bala 'temps) (get 'bala 'temps))))
)

