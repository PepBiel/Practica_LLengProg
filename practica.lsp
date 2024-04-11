(defun inici ()
    (inici-objectes)
    (pinta))

(defun inici-objectes ()
    (inici-camp)
    (inici-mur)
    (inici-campesquerre)
    (inici-campdret)
    )

(defun inici-camp ()
    (putprop 'camp 339 'altura)
    (putprop 'camp 639 'amplada))

(defun inici-mur ()
    (putprop 'mur (numero-aleatori 100 150) 'altura)
    (putprop 'mur (numero-aleatori 20 40) 'amplada))

(defun inici-campesquerre ()
    (putprop 'campesq 15 'altura)
    (putprop 'campesq 285 'amplada))

(defun inici-campdret ()
    (putprop 'campdr 45 'altura)
    (putprop 'campdr 325 'amplada))

(defun pinta ()
    (cls)
    (pinta-camp)
    (pinta-mur)
    (pinta-camps))

(defun pinta-camp()
    (color 0 0 0)
    (rectangle 0 0 (get 'camp 'amplada) (get 'camp 'altura)))

(defun pinta-mur()
    (color 205 133 63)
    (rectangle 285 0 (get 'mur 'amplada) (get 'mur 'altura)))

(defun pinta-camps()
    (color 0 143 57)
    (move 0 (get 'campesq 'altura))
    (draw (get 'campesq 'amplada) (get 'campesq 'altura))
    (moverel (get 'mur 'amplada) 30)
    (drawrel (get 'campdr 'amplada) 0))


(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h)))

(defun numero-aleatori (minim maxim)
    (+ minim (random (+ 1 (- maxim minim)))))

(defun calcul-mur ()
    )