#! /usr/bin/env/racket
#lang racket

;@ Title: Given 3 numbers the following program computes the sum of largest two. 

;Helper Function to compute the square of given input x
(define (square x) (* x x)) ;:-> number?

;Helper Function to compute the sum of square of given two inputs x and y.
(define (sum-of-square x y) (+ (square x) (square y))) ;:-> number?

;Function to find the largest two numbers of a given three numbers x,y,z and 
;computes the sum of squares
(define (sum-of-square-of-largest-two x y z) ;:-> number?
        (if ( > x y) 
            (sum-of-square x (max y z))
            (sum-of-square y (max x z))))

(sum-of-square-of-largest-two 2 3 4)
         
