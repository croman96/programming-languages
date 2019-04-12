#lang racket

;; Contract: tester : number number -> boolean

;; Purpose: to compare two numbers and check if they are equal

;; Example: (tester 25 25) should produce true

;; Definition: [refines the header]
(define (tester expected given)
  (cond
    [(= expected given) true]
    [else false]))



;; Contract: triangle-area : number number -> number

;; Purpose: to compute the area of a triangle given base and height

;; Example: (triangle-area 25 30) should produce 375

;; Definition: [refines the header]
(define (triangle-area b h)
  (* b h 1/2))

;; Tests:
(tester (triangle-area 25 30) 375)



;; Contract: func-a : number -> number

;; Purpose: to compute (n^2) + 10

;; Example: (func-a 2) should produce 14

;; Definition: [refines the header]
(define (func-a n)
  (+ (sqr n) 10))

;; Tests:
(tester (func-a 2) 14)



;; Contract: func-b : number -> number

;; Purpose: to compute ((n^2)/2) + 20

;; Example: (func-b 2) should produce 22

;; Definition: [refines the header]
(define (func-b n)
  (+ (* 1/2 (sqr n)) 20))

;; Tests:
(tester (func-b 2) 22)



;; Contract: func-c : number -> number

;; Purpose: to compute 2 - (1/n)

;; Example: (func-c 2) should produce 1.5

;; Definition: [refines the header]
(define (func-c n)
  (- 2 (/ 1 n)))

;; Tests:
(tester (func-c 2) 1.5)



;; Contract: solutions : number number number -> number

;; Purpose: to compute the number of possible solutions of a quadratic equation
;; given a, b, c values representing equation's variables.

;; Example: (solutions 1 0 -1) should produce 2

;; Definition: [refines the header]
(define (solutions a b c)
  (cond
    [(> (sqr b) (* 4 a c)) 2]
    [(= (sqr b) (* 4 a c)) 1]
    [(< (sqr b) (* 4 a c)) 0]))

;; Tests:
(tester (solutions 1 0 -1) 2)
(tester (solutions 2 4 2) 1)
