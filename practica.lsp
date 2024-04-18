(defun inici ()
    (inici-objectes)
    (pinta))

(defun inici-objectes ()
    (inici-camp)
    (inici-mur)
    (inici-campesquerre)
    (inici-campdret)
    (inici-canoesquerr)
    (inici-canodret)
)

;Posam aquests valors perque es vegi la línea del camp, però realment el camp és de 340x640
(defun inici-camp ()
    (putprop 'camp 339 'altura)
    (putprop 'camp 639 'amplada)
    (putprop 'camp (numero-aleatori 0 40) 'diferencia))

; inicialitzam valors aleatoris del mur
(defun inici-mur ()
    (putprop 'mur (numero-aleatori 100 150) 'altura)
    (putprop 'mur (numero-aleatori 20 40) 'amplada))

(defun inici-campesquerre ()
    (putprop 'campesq (numero-aleatori 15 45) 'altura)
    (putprop 'campesq (generar-campesq) 'amplada))

(defun inici-campdret ()
    (putprop 'campdr (numero-aleatori 15 45) 'altura)
    (putprop 'campdr (generar-campdret) 'amplada))

(defun inici-canoesquerr ()
    (putprop 'canoesq 10 'altura)
    (putprop 'canoesq 20 'amplada)
    (putprop 'canoesq (numero-aleatori 
           (floor (/ (get 'campesq 'amplada) 3))
           (* (floor (/ (get 'campesq 'amplada) 3)) 2)) 'posicio))

(defun inici-canodret ()
    (putprop 'canodr 10 'altura)
    (putprop 'canodr 20 'amplada)
    (putprop 'canodr (numero-aleatori 
           (floor (/ (get 'campdr 'amplada) 3))
           (* (floor (/ (get 'campdr 'amplada) 3)) 2)) 'posicio))

(defun pinta ()
    (cls)
    (pinta-camp)
    (pinta-mur)
    (pinta-camps)
    (pinta-canons)
)

(defun pinta-camp()
    (color 0 0 0)
    (rectangle 0 0 (get 'camp 'amplada) (get 'camp 'altura))
)

(defun pinta-mur()
    (color 205 133 63)
    (rectangle (get 'campesq 'amplada) 0 (get 'mur 'amplada)
         (get 'mur 'altura)))

(defun pinta-camps()
    (color 0 143 57)
    (move 0 (get 'campesq 'altura))
    (draw (get 'campesq 'amplada) (get 'campesq 'altura))
    (move (+ (get 'mur 'amplada) (get 'campesq 'amplada)) 
        (get 'campdr 'altura))
    (draw (get 'camp 'amplada) (get 'campdr 'altura)))

(defun pinta-canons()
    (color 0 0 0)
    ;cano esquerre
    (rectangle (get 'canoesq 'posicio) (get 'campesq 'altura) 
        (get 'canoesq 'amplada) (get 'canoesq 'altura))
    ;cano dret
    (rectangle (+ (get 'canodr 'posicio) 
    (+ (get 'campesq 'amplada) (get 'mur 'amplada))) 
        (get 'campdr 'altura) (get 'canodr 'amplada) 
        (get 'canodr 'altura))
)


(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h)))

(defun numero-aleatori (minim maxim)
    (+ minim (random (+ 1 (- maxim minim)))))

; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li restam la diferència dividida entre 2
;(defun generar-campesq ()
;    (- (/ (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
;        (/ (get 'camp 'diferencia) 2)))

(defun generar-campesq ()
    (let ((resultado (- (/ (- (+ (get 'camp 'amplada) 1) 
        (get 'mur 'amplada)) 2) (/ (get 'camp 'diferencia) 2))))
            (floor resultado))) ; Redondear hacia abajo para asegurar un número entero


; sumam 1 a l'amplada del camp, li restam el mur, ho dividim entre 2 i li sumam la diferència dividida entre 2
;se pot eliminar ja que per dibuixar no ho utilitzam
(defun generar-campdret ()
    (+ (/ (- (+ (get 'camp 'amplada) 1) (get 'mur 'amplada)) 2) 
        (/ (get 'camp 'diferencia) 2)))