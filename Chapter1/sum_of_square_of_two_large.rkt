#! /usr/bin/env/racket
#lang racket

(define (square x) (* x x))
(define (sum-of-square x y) (+ (square x) (square y)))
(define (sum-of-square-of-largest-two x y z)
        (if ( > x y) 
            (sum-of-square x (max y z))
            (sum-of-square y (max x z))))

(sum-of-square-of-largest-two 2 3 4)
         
