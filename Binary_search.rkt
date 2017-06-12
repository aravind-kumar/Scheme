#lang racket
(require 2htdp/universe 2htdp/image)

(define WIDTH 1000)
(define HEIGHT 500)
(define TEXT-HEIGHT 50)

(struct interval (low high) #:transparent)

(define HELP-TEXT
  (text "Press Up-Arrow for increase and Down-Arrow for decrease"
        20
        "blue"))

(define HELP-TEXT2
  (text "Press = or q to Quit"
        20
        "blue"))

(define start-scene
  (place-image/align
   HELP-TEXT 10 20 "left" "top"
   (place-image/align
    HELP-TEXT2 10 70 "left" "bottom"
    (empty-scene WIDTH HEIGHT))))

(define (guess current-world)
  (quotient (+ (interval-low current-world)
                             (interval-high current-world)) 2))

(define (bigger current-world)
  (interval (min (interval-high current-world)
                  (add1 (guess current-world)))
             (interval-high current-world)))

(define (smaller current-world)
  (interval (interval-low current-world)
            (max (interval-low current-world)
                 (sub1 (guess current-world)))))

(define (single? current-world)
  (= (interval-low current-world) (interval-high current-world)))

(define (print-current-guess current-state)
    (overlay (text (string-append "Low is : " (number->string (interval-low current-state))
                                " ,High is: " (number->string (interval-high current-state)))
                 20
                 "blue") 
             (place-image/align (text (number->string (guess current-state)) 50 "blue")
                                10 150 "left" "bottom"
                                start-scene)))

(define (improve-guess world key)
  (cond [ (key=? key "up") (bigger world) ]
        [ (key=? key "down") (smaller world) ]
        [ (key=? key "=") (stop-with world) ]
        [ (key=? key "q") (stop-with world) ]))


(define (render-last-scene world )
  (overlay (text (string-append "End.The Guess is " (number->string (guess world)))
                                20 "blue") start-scene))

(define (start low high)
  (big-bang (interval low high)
            (on-key improve-guess)
            (to-draw print-current-guess)
            (stop-when single? render-last-scene)))

            