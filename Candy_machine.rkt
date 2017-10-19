#lang racket

(define quater 25)

(struct snack (name capacity price) #:transparent)

(struct cash (denomination quantity) #:transparent)

(struct machine (Snacks Bank input-cash) #:transparent)

(define cost-of-kale (cash quater 3))

(define cost-of-carrot (cash quater 2))

(define (get-input-money machine-state)
  (define customer-input (machine-input-cash machine-state))
  cash-quantity customer-input)

(define (is-equals? snackName given-snack)
  (define given-snack-name (snack-name given-snack))
  (string=? snackName given-snack-name))

(define (get-bank-balance machine-state)
  (define bank (machine-bank machine-state))
  (* (cash-denomination bank) (cash-quantity bank)))

(define (intial-state num-of-kale num-of-carrot)
  (define kale (snack "kale" num-of-kale cost-of-kale))
  (define carrot (snack "carrot" num-of-carrot cost-of-carrot))
  (define customer-input (cash quater 0))
  (define list-of-snacks (list kale carrot))
  (machine list-of-snacks
           (cash quater 0)
           customer-input))

(define (add-input-money machine-state customer-input)
  (define present-money (get-input-money machine-state))
  (define new-money (cash quater (+ present-money customer-input)))
  new-money)

(define (machine-next-state machine-state customer-input)
  (define given-snack (get-snack customer-input machine-state))
  (cond [(and (number? customer-input) (> customer-input 0))
         (add-input-money machine-state customer-input)]
        [(snack? given-snack)
         ()]

(define (buy-snack given-snack machine-state)
  (define snack-quantity (snack-capacity given-snack))
  (define new-quantity (sub1 snack-capacity))
  (define new-snack (struct-copy snack given-snack
                                 [capacity new-quantity]))
  new-snack)

(define (deduce-input-money given-snack machine-state)
  (define snack-cost (snack-price given-snack))
  (define input-money (get-input-money machine-state))
  (define new-input-balance (- input-money snack-cost))
  (define new-input (add-input-money (- new-input-balance) machine-state))
  new-input)

(define (replace item with in)
  (map (lambda (arg)
         (if (equal? item arg)
             with
             arg))
       in))

(define (cash-diff old-cash new-cash)
  (define old-cash-quantity (cash-quantity old-cash))
  (define new-cash-quantity (cash-quantity new-cash))
  (- old-cash-quantity new-cash-quantity))

(define (add-bank-money machine-state new-input-cash)
  (define present-bank (machine-bank machine-state))
  (define old-input-cash (input-cash (machine-Given-input machine-state)))
  (define cash-difference (cash-diff old-input-cash new-input-cash))
  (cash quater (+ cash-quantity present-bank cash-difference)))

(define (buy given-snack machine-state)
  (define new-snack (buy-snack given-snack machine-state))
  (define present-snacks (machine-Snacks machine-state))
  (define new-snacks (replace new-snack given-snack present-snacks))
  (define new-input (deduce-input-money given-snack machine-state))
  (define new-bank (add-bank-money machine-state (input-cash new-input)))
  (machine new-snacks new-bank new-input))

(define (can-buy? given-snack machine-state)
  (define snack-name (snack-name given-snack))
  (define snack-cost (snack-price given-snack))
  (define num-of-snack (get-remaning-snacks snack-name machine-state))
  (define input-money (get-input-money machine-state))
  (when (zero? num-of-snack) "Out of item")
  (when (> input-money snack-cost) #t)
  machine-state)

(define (buy-if-possible given-snack machine-state)
  (define result (can-buy? given-snack machine-state))
  (if (equal? result #t)
      (buy given-snack machine-state)
      result))

;;Shoudnt return a new-machine-state but rather should return strings but how to persist the new machine state then ?
(define (machine-output machine-state customer-input)
  (define next-machine-state (machine-next-state machine-state customer-input))
  (define input-money (get-input-money next-machine-state))
  (define given-snack (get-snack customer-input machine-state))
  (cond [given-snack
         (buy-if-possible given-snack machine-state)]
        [(string=? "change" customer-input)
         (cash-quantity input-money)]
        [(number? customer-input) next-machine-state]))

(define (get-snack input-string machine-state)
  (define snacks (machine-Snacks machine-state))
  (findf (curry is-equals? input-string) snacks))

(define (get-remaning-snacks item machine-state)
  (define given-snack (get-snack item machine-state))
  (if given-snack
      (snack-capacity given-snack)
      machine-state))

(define (machine-remaning-kale machine-state)
  (define remaning-kales (get-remaning-snacks "kales" machine-state))
  (max 0 remaning-kales))

(define (machine-remaning-carrots machine-state)
  (define remaning-carrots (get-remaning-snacks "carrots" machine-state))
  (max 0 remaning-carrots))

(define (machine-bank machine-state)
  (define bankamount (get-bank-balance machine-state))
  (max 0 bankamount))
