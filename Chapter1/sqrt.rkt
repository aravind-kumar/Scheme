#! /usr/bin/env/racket
#lang racket

; @Title:Find the square root of a given number

; For computing the square root we make an intital guess 
; and check if the guess is correct by squaring the guess 
; and checking it's equal to given number.
; If the guess happens to be incorrect we improve the guess 
; by averaging the guess and (given_number/guess) 
; (i.e. new_guess = ( / (+ (guess) (/ given_number guess)) 2) 
;  or   new_guess = ((guess + (given_number/guess ))/2)

; TODO: Learn how to re-use functions in previous examples
; TODO: Find out how to make it more generic ? Given a improve-guess and good-enough 
;       function we should be able to generalize this function for cube-root,forth root etc.

;Function to square a given input
(define (square x) (* x x))

;Function to improve the guess.
;It averages guess and give_number/guess
(define (improve_guess guess given_number)
        (/ (+ guess (/ given_number guess)) 2))

;Funtion to check if the guess is good enough
;It checks by checking if square of the guess is equal to the given number
;Note: This could sometimes take alot of time,
;      To improve on that we could calculate the absolute difference between
;      (square guess) and give_number to given precision limit like 0.0001
;       making the result precise till 0.001
(define (is-guess-good-enough? guess given_number)
        (equal? (square guess) given_number)) 

;Function sqrt-helper checks if guess if good enough
;If so returns the guess
;Otherwise improves the guess and call's itself with the improved guess.
(define (sqrt-helper guess given_number)
        (if (is-guess-good-enough? guess given_number)
            guess
            (sqrt-helper (improve_guess guess given_number) given_number))) 

;Main sqrt function which takes an input x for computing the sqrt
(define (sqrt x)
        (sqrt-helper 1.0 x)) ; Note that guess here is given as 1.0 rather than 1,if given as 1 
                             ; the result would be in rational form rather than decimal

(sqrt 25.0)
