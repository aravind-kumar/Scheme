#lang racket
(require 2htdp/universe 2htdp/image)

(define ufo (circle 20 "solid" "blue"))

(define WIDTH 1000)

(define HEIGHT 1000)

(struct state (x y) #:transparent)

(define intial-state (state (quotient WIDTH 2) 0))

(define (place-ufo-at present-state)
  (place-image ufo (state-x present-state)
                   (state-y present-state)
                   (empty-scene 1000 1000)))

(define (update-current-state present-state)
  (state (state-x intial-state)
                 (+ (state-y present-state) 3))) 

(big-bang intial-state
          (on-draw place-ufo-at)
          (on-tick update-current-state))
          

          