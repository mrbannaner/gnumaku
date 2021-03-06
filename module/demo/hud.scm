(define-module (demo hud)
  #:use-module (srfi srfi-9)
  #:use-module (gnumaku core)
  #:use-module (gnumaku assets)
  #:use-module (demo player)
  #:export (make-hud hud-width hud-height hud-player hud-font hud-life-image
                     set-hud-width! set-hud-height! set-hud-font! set-hud-life-image! draw-hud))

(define-record-type Hud
  (%make-hud width height player font life-image)
  hud?
  (width hud-width set-hud-width!)
  (height hud-height set-hud-height!)
  (player hud-player)
  (font hud-font set-hud-font!)
  (life-image hud-life-image set-hude-life-image!))

(define (make-hud width height player)
  (%make-hud width height player (load-asset "CarroisGothic-Regular.ttf" 14) (load-asset "heart.png")))

(define (draw-lives x y hud)
  (font-draw-text (hud-font hud) x y '(1 1 1 1) "Lives")
  (let ((image (hud-life-image hud)))
    (let draw-life-icon ((i 0)
                         (x x)
                         (y (+ y 16)))
      (when (< i (lives (hud-player hud)))
        (draw-image image x y)
        (draw-life-icon (1+ i) (+ x (image-width image)) y)))))

(define (draw-hud hud)
  (draw-lives 520 20 hud))
