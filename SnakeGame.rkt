#lang racket

(define WIDTH 1000)
(define HEIGHT 700)

(struct pit (snake goos))

(struct snake (direction segs))

(struct goo (position expire))

(struct position (x y))

(define current-snake
  (snake ("up"
          (list (position
                 (quotient WIDTH 2)
                 (quotient HEIGHT 2))))))

(define goo-list-example
  (list
   (goo (position (30 80)) 30)
   (goo (position (90 100)) 40)
   (goo (position (50 199)) 60)))

