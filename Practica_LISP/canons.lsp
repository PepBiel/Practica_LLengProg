;**************************************************************
;************************ PRÀCTICA LISP ***********************
;**************************************************************

; *************************** AUTORS ****************************

; Jordi Florit Ensenyat
; Josep Gabriel Fornés Reynés

;********************* INICIALITZACIONS *************************

; FUNCIÓ INICIAL
(defun inicia ()
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

; INICIALITZAM EL VENT
(defun inici-vent ()
    (putprop 'vent (- (numero-aleatori 0 10) 5) 'vent)
)

; INICIALITZAM LA BANDERA
(defun inici-bandera ()
    (putprop 'bandera (+ (get 'campesq 'amplada) 
                        (floor (/ (get 'mur 'amplada) 2))) 'posicioX)
    (putprop 'bandera (get 'mur 'altura) 'posicioY)
    (putprop 'bandera 20 'pal)
    (putprop 'bandera 20 'amplada)
    (putprop 'bandera 10 'altura)
)

;************************ MENU ************************************

; MOSTRAM MENU PRINCIPAL
; sols mostram per pantalla un text per indicar el titol i els 
; membres que han realitzat aquesta pràctica
(defun menu()
    (cls)   ; natejam la pantalla
    (color 0 0 0)   ; color  negre
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

; MENU QUE MOSTRA LES INDICACIONS/INSTRUCCIONS DEL JOC
(defun instruccions()
    (cls)   ; natejam la pantalla
    (color 0 0 0)   ; color  negre
    (princ "A continuacio us explicarem les principals instruccions ")
    (princ "que s'han de saber abans de començar a jugar:")
    (terpri)
    (princ "- El primer que aconseguesqui destruir el cano ")
    (princ "de l'adversari serà el guanyador.")
    (terpri)
    (princ "- Podra disparar el cano que tingui el torn. ")
    (princ "Si no es el torn del cano no podra disparar.")
    (terpri)
    (princ "- El primer torn es aleatori.")
    (terpri)
    (princ "- Les posicions dels camps, canons i mur ")
    (princ "tambe son aleatoris.")
    (terpri)
    (princ "- El vent influeix en el dispar segons la direccio ")
    (princ "i longitud de la bandera.")
    (terpri)
    (princ "Controls cano esquerre:")
    (terpri)
    (princ "    - a -> moure cano cap a l'esquerre.")
    (terpri)
    (princ "    - d -> moure cano capa a la dreta.")
    (terpri)
    (princ "    - w -> incrementam angle de dispar.")
    (terpri)
    (princ "    - s -> decrementam angle de dispar.")
    (terpri)
    (princ "    - e -> augmentam potencia.")
    (terpri)
    (princ "    - q -> decrementam potencia.")
    (terpri)
    (princ "    - f -> disparar.")
    (terpri)
    (princ "Controls cano dreta:")
    (terpri)
    (princ "    - j -> moure cano cap a l'esquerre.")
    (terpri)
    (princ "    - l -> moure cano capa a la dreta.")
    (terpri)
    (princ "    - i -> incrementam angle de dispar.")
    (terpri)
    (princ "    - k -> decrementam angle de dispar.")
    (terpri)
    (princ "    - u -> augmentam potencia.")
    (terpri)
    (princ "    - o -> decrementam potencia.")
    (terpri)
    (princ "    - h -> disparar.")
    (terpri)
    (princ "Pitja ESPAI per tornar al joc.")
    (setq tecla (get-key))
    (cond ((equal tecla 32) ; Pitjam espai
                    (repeteix))
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

; PINTAM PAL DE LA BANDERA
(defun pinta-pal ()
    (move (get 'bandera 'posicioX) (get 'bandera 'posicioY))
    (draw (get 'bandera 'posicioX) (+ (get 'bandera 'posicioY) 
                                    (get 'bandera 'pal)))
)

; PINTAM LA BANDERA
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

; SECCIONAM LA BANDERA
; cal dir que per visualitzar la quantitat de vent s'ha de mirar a la bandera i contar 
; el nombre de pals de color negre que hi ha dintre de la bandera
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

; GENERAM UN NOMBRE ALEATORI ENTRE MINIM I MAXIM
(defun numero-aleatori (minim maxim)
    (+ minim (random (+ 1 (- maxim minim))))
)

;************************ REPETICIÓ ************************************

; FUNCIO REPETEIX
; és una de les funcions més importants del joc. Aqui miram si es 
; pulsa alguna tecla i es fa les funcions pertinents
(defun repeteix ()
    (cond ((= (get 'joc 'acabat) 0)
                (pinta)
                (princ "Pitja ESC per sortir o ")
                (princ "ESPAI per veure les instruccions.")
                (terpri)
                (cond ((= (get 'joc 'torn) 0)   ; torn cano dret 
                            (princ "Es el torn del cano dret. "))  
                        (t (princ "Es el torn del cano esquerre. "))   ; torn cano esquerre 
                )
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
                                    (t (format t "No es el teu torn")
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
                                    (t (format t "No es el teu torn")
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

; FUNCIO QUE PASSA DE GRAUS A RADIANS
(defun radians (graus)
  (/ (* graus (* 2 pi)) 360))

; DIBUIXA AMB LES COORDENADES ARRODONIDES
(defun drawr (x y)
  "pinta a les coordenades arrodonides"
  (draw (round x) 
        (round y)))

; *************************** ACCIONS CANONS *********************************

; DISPARAM CANO
(defun dispara-canons (cano)
    ; Inicialitza els paràmetres de la bala per al canó especificat
    (ini-bala cano)
    ; Inicia el bucle principal de moviment de la bala
    (bucle cano)
    ; Dibuixa la trajectòria de la bala
    (dibuixar-bolla cano))

(defun bucle (cano)
    ;Calcula les noves posicions i velocitats de la bala
    (calcular cano)
    ; Dibuixa la nova posició de la bala
    (dibuixar cano)
    ; Verifica col·lisions i altres condicions per aturar la bala
    (aturada cano)
)

(defun calcular (cano)
    ; Pausa breument per permetre una animació suau
    (sleep 0.0001)
    ; Calcula la nova velocitat de la bala
    (calc-vel cano)
    ; Calcula la nova posició de la bala
    (calc-pos cano)
    ; Incrementa el temps de vol de la bala
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
                ; Mostra un missatge indicant a l'usuari que premi la tecla espai per continuar
                (format t "Pitja la tecla espai per continuar")
                (setq tecla (get-key))
                (cond ((equal tecla 32) ; Pitjam espai
                                (cond ((= (get 'joc 'torn) 0)   ; torn cano dret 
                                            (putprop 'joc 1 'torn))  
                                        (t (putprop 'joc 0 'torn))   ; torn cano esquerre 
                                )
                                (repeteix)) ; incrementa angle cano esquerre i repeteix
                        (t                 ; altrament
                        ; Si es prem una altra tecla, tornar a esperar l'entrada
                        (terpri) (esperar-entrada))))
            ; Si el joc ha acabat, repeteix
            (t (repeteix)))
)

(defun cercle (x y radi segments)
    (mover (+ x radi) y)
    (cercle2 x y radi (/ 360 segments) 0)) ; Dibuixa el cercle mitjançant segments

(defun cercle2 (x y radi pas angle)
  (cond ((< angle 360)
         (drawr (+ x (* radi (cos (radians (+ angle pas)))))
                (+ y (* radi (sin (radians (+ angle pas))))))
         (cercle2 x y radi pas (+ angle pas))) ; Crida recursiva per al següent segment
        (t t)))

(defun mover (x y) ; Mou el cursor a la posició arrodonida especificada
  "mou a les coordenades arrodonides"
  (move (round x) 
        (round y)))

(defun drawr (x y)  ; Pinta un punt a la posició arrodonida especificada
  "pinta a les coordenades arrodonides"
  (draw (round x) 
        (round y)))

(defun aturada (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            ; Verifica col·lisió amb el canó dret
            (colisio-canodret cano))

        ((= cano 0) ; Si es el cano dret
            ; Verifica col·lisió amb el canó esquerre
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
                                ; Si hi ha col·lisió, marca el joc com acabat i mostra el missatge de victòria
                                (putprop 'joc 1 'acabat)
                                (format t "Victoria del cano esquerre")
                                (terpri))
                             ; Si no hi ha col·lisió amb el canó dret, verifica col·lisió amb el camp dret
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
                                ; Si hi ha col·lisió, marca el joc com acabat i mostra el missatge de victòria
                                (putprop 'joc 1 'acabat)
                                (format t "Victoria del cano dret")
                                (terpri))
                            ; Si no hi ha col·lisió amb el canó esquerre, verifica col·lisió amb el camp dret    
                            (t (colisio-campdret cano))))
        (t (colisio-campdret cano)))
)

(defun colisio-campdret (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (cond ((and (> (get 'bala-esq 'X) (get 'campdr 'posicio-campdr)) 
                        (< (get 'bala-esq 'Y) (get 'campdr 'altura))))
            (t (colisio-mur cano)))) ;Si no hi ha col·lisió amb el camp dret, verifica col·lisió amb mur  

        ((= cano 0) ; Si es el cano dret
            (cond ((and (> (get 'bala-dr 'X) (get 'campdr 'posicio-campdr)) 
                        (< (get 'bala-dr 'Y) (get 'campdr 'altura))))
            (t (colisio-mur cano)))) ;Si no hi ha col·lisió amb el camp dret, verifica col·lisió amb mur  
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
                                        ; Si hi ha col·lisió amb el mur, continuar en el bucle
                                        (t (bucle cano))))
                    ;Si no hi ha col·lisió amb el mur, verifica col·lisió amb el camp-esquerra
                    (t (colisio-campesq cano))))

        ((= cano 0) ; Si es el cano dret
            (cond ((and (>= (get 'bala-dr 'X) (get 'campesq 'amplada))
                        (<= (get 'bala-dr 'X) 
                            (get 'campdr 'posicio-campdr)))
                                (cond ((<= (get 'bala-dr 'Y) 
                                    (get 'mur 'altura)))
                                        ; Si hi ha col·lisió amb el mur, continuar en el bucle
                                        (t (bucle cano))))
                    ;Si no hi ha col·lisió amb el mur, verifica col·lisió amb el camp-esquerra
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

;Funció per incrementar el temps de vol de la bala
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
            ;Calcula i estableix la velocitat inicial en el eix X
            (putprop 'bala-esq (* (get 'canoesq 'potencia) 
                (cos (* (get 'canoesq 'angle) (/ pi 180)))) 'vix)

            ;Calcula i estableix la velocitat inicial en el eix Y
            (putprop 'bala-esq (* (get 'canoesq 'potencia) 
                (sin (* (get 'canoesq 'angle) (/ pi 180)))) 'viy)
            
            (putprop 'bala-esq -9.8 'acceleracio) ;Estableix la acceleració de la bala
            (putprop 'bala-esq 0 'temps) ;Inicialitzar temps de vol a 0
            (putprop 'bala-esq (get 'canoesq 'X) 'X) ;Punta vector x
            (putprop 'bala-esq (get 'canoesq 'Y) 'Y) ;Punta vecetor y
            (putprop 'bala-esq 5 'radi) ;Radi de la bala
            (putprop 'bala-esq 0 'trajectoria) ;Inicialitzar trajectoria
            (mover (get 'bala-esq 'X) (get 'bala-esq 'Y))) ;Moure el cursor a la posicio inicial de la bala

        ((= cano 0) ; Si es el cano dret (inicialitzacio igual que la esquerra)
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

;Defineix la nova velocitat de la bala tant per eix X i Y (formules enunciat)
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

;Funció auxilair per calcular velocitat en el eix X
(defun calc-velx (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'vix) (* (get 'vent 'vent) 
                (get 'bala-esq 'temps))))

        ((= cano 0) ; Si es el cano dret
            (+ (get 'bala-dr 'vix) (* (get 'vent 'vent) 
                (get 'bala-dr 'temps))))
        (t
            (format t "Cano no reconegut."))
    )
)
    
;Funció auxilair per calcular velocitat en el eix Y
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

;Defineix la nova posició de la bala tant per eix X i Y (formules enunciat)
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

;Funció auxilair per calcular posició en el eix X
(defun calc-posx (cano)
    (cond
        ((= cano 1) ; Si es el cano esquerre
            (+ (get 'bala-esq 'X) (* (get 'bala-esq 'vix) 
            (get 'bala-esq 'temps))))

        ((= cano 0) ; Si es el cano dret
            (+ (get 'bala-dr 'X) (* (get 'bala-dr 'vix) 
            (get 'bala-dr 'temps))))
        (t
            (format t "Cano no reconegut."))
    )
)

;Funció auxilair per calcular posició en el eix Y
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

;Pausar la execució del programa (aula digital)
(defun sleep (seconds)
    "Espera la quantitat indicada de segons"
    ; Això és un bucle iteratiu. NO PODEU FER-NE SERVIR ENLLOC MÉS
    (do ((endtime (+ (get-internal-real-time)
    (* seconds internal-time-units-per-second))))
    ((> (get-internal-real-time) endtime))))

;Crida per iniciar el programa
(inicia)
