(use-modules (srfi srfi-9))

(define-record-type FPS
  (%make-fps game last-time time-acc frames last-frames)
  fps?
  (game fps-game)
  (last-time fps-last-time set-fps-last-time!)
  (time-acc fps-time-acc set-fps-time-acc!)
  (frames fps-frames set-fps-frames!)
  (last-frames fps-last-frames set-fps-last-frames!))

(define (make-fps game)
  (%make-fps game 0 0 0 0))

(define (inc-fps-time-acc! fps time)
  (set-fps-time-acc! fps (+ (fps-time-acc fps) time)))

(define (inc-fps-frames! fps)
  (set-fps-frames! fps (1+ (fps-frames fps))))

(define (fps-update! fps)
  (let ((time (game-get-time (fps-game fps))))
    (inc-fps-time-acc! fps (- time (fps-last-time fps)))
    (inc-fps-frames! fps)
    (set-fps-last-time! fps time)
    (when (>= (fps-time-acc fps) 1)
      (set-fps-last-frames! fps (fps-frames fps))
      (set-fps-frames! fps 0)
      (inc-fps-time-acc! fps -1))))