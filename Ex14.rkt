#lang racket

(define (string-last input-string)
  (substring input-string
             (- (string-length input-string) 1)))
