#lang racket
(require 2htdp/universe 2htdp/image)

(define WIDTH 1000)

(define HEIGHT 700)

(define ufo (circle 20 "solid" "blue"))

(struct state (x y)#:transparent)

(define intial-state (state (quotient WIDTH 2) 0))

(define (place-current-image current-world)
  (place-image ufo (state-x current-world) (state-y current-world)
               (empty-scene WIDTH HEIGHT)))

(define (descent-plane current-world)
  (struct-copy state current-world
               [y (modulo
                   (+ (state-y current-world) 1)
                   HEIGHT)]))

(define (go-north current-state)
  (struct-copy state current-state
               [y (modulo
                   (- (state-y current-state) 10)
                   HEIGHT)]))

(define (go-south current-state)
  (struct-copy state current-state
               [y (modulo
                   (+ (state-y current-state) 10)
                   HEIGHT)]))

(define (go-east current-state)
  (struct-copy state current-state
               [x (modulo
                   (- (state-x current-state) 10)
                   WIDTH)]))

(define (go-west current-state)
  (struct-copy state current-state
               [x (modulo
                   (+ (state-x current-state) 10)
                   WIDTH)]))

(define (update-current-state current-world key)
  (cond [(key=? key "q") (stop-with current-world)]
        [(key=? key "up") (go-north current-world)]
        [(key=? key "down") (go-south current-world)]
        [(key=? key "left") (go-east current-world)]
        [(key=? key "right") (go-west current-world)]))

(big-bang intial-state
          (on-key update-current-state)
          (on-tick descent-plane)
          (to-draw place-current-image))


          



