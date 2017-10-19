#! /bin/env/racket
#lang racket

(define (swap x y)
	(define temp x)
	(set! x y)
	(set! y temp))

(define (bubble-sort input-list)
	(define (swap-if-greater x y)
		(cond (> x y) (swap x y)))
	(map (lambda (input) 
			(define index-of-input (index-of input-list input))
 			(cond (< index-of-input (sub1 (length input-list)))
			      (let ([next-element (list-ref input-list (add1 index-of-input))])
			      		(swap-if-greater input next-element))))
	input-list))

(bubble-sort (reverse (build-list 10 values)))

;(define (bubble-sort input-list)
;        (define (bubble-sort-helper input-list-length number-of-sorted-elements)
;		(if (equal? input-list-lenght number-of-sorted-elements)
;            	     input-list
;                ((map input-list lambda )
;                 (bubble-sort-helper (add1 number-of-sorted-elemets)))))
;	bubble-sort-helper (length input-list) 0)
