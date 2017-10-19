#lang racket



(define (square-surface-area x)
  (* x x))

(define (csurface x)
  (* 6 (square-surface-area x)))

(define (cvolume x)
  (* x (square-surface-area x)))
