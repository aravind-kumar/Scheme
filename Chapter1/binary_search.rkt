#! /bin/env/racket
#lang racket

(define (binary-search input-list given-num)
        (define (binary-search-helper min max)
                (if (>= max min)
                    (let* ( [ position (quotient (+ min max) 2) ]
                            [ element-at-position (list-ref input-list (sub1 position)) ])
                      (cond 
                      [ (equal? given-num element-at-position) (sub1 position) ]
                      [ (< given-num element-at-position) (binary-search-helper min (sub1 position)) ] 
                      [ (> given-num element-at-position) (binary-search-helper (add1 position) max) ]))
	       -1))
	(binary-search-helper 0 (length input-list)))

(binary-search (build-list 11 values) 1234)
