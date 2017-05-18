#! /bin/env/racket
#lang racket

(define (binary-search input-list num)
        (define (binary-search-helper min max)
                (define position (quotient (+ min max) 2))
                (define element-at-position (list-ref input-list position))
		(cond (equal? element-at-position num) 
		      	(position)
                      (< element-at-position num)
                      	(binary-search-helper min position)
                      (> element-at-position num)
			(binary-search-helper position max)))
	(binary-search-helper 0 (length input-list)))

(binary-search (build-list 10 values) 5)
