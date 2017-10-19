#lang racket
(require 2htdp/universe 2htdp/image lang/posn)

(struct state (lower upper iter))

(define (lower-equals-upper? current-state)
  (= (state-lower current-state) (state-upper current-state)))

(define (guess current-state)
  (quotient (+ (state-lower current-state)
               (state-upper current-state)) 2))

(define (lower current-state)
  (struct-copy state current-state
               [upper (max (state-lower current-state)
                            (guess current-state))]
               [iter (add1 (state-iter current-state))]))

(define (higher current-state)
  (struct-copy state current-state
               [lower (min (state-upper current-state)
                           (guess current-state))]
               [iter (add1 (state-iter current-state))]))

(define WIDTH 1000)
(define HEIGHT 1000)

(define HELP-TEXT
  (text "Press Up Arrow for increase in guess"
        20
        "blue"))

(define HELP-TEXT2
  (text "Press Down Arrow for decrease in guess"
        20
        "blue"))


(define background-scene
  (place-images/align
   (list HELP-TEXT HELP-TEXT2) 
   (list (make-posn 10 30)
         (make-posn 10 60))
   "left" "top"
   (empty-scene WIDTH HEIGHT)))


(define (render-current-state current-state)
  (define (get-guess guess)
    (string-append "The current Guess is : "
                   (number->string guess)))
  (define (get-iter iter-no)
    (string-append "Iteration Number : "
                   (number->string iter-no)))
  
  (place-images/align
   (list (text (get-guess (guess current-state)) 20 "red")
         (text (get-iter (state-iter current-state)) 20 "red"))
   (list (make-posn 350 300)
         (make-posn 350 350))
   "left" "middle"
   background-scene))

(define (improve-guess current-world key)
  (cond [ (key=? key "up") (higher current-world)]
        [ (key=?  key "down") (lower current-world)]
        [ (or (key=? key "=") (key=? key "q") (stop-with current-world))]))

(big-bang (state 0 100 0)
          (on-key improve-guess)
          (to-draw render-current-state)
          (stop-when lower-equals-upper?))