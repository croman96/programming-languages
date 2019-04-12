#lang racket

;; Contract: power-head : number number -> number

;; Purpose: calculate the power of a given number using head recursion

;; Example: (power-head 4 3) should produce 64

;; Definition: [refines the header]

(define (power-head b e)
  (if (= e 0)
      1
      (* b (power-head b (- e 1)))))

;; Tests

(equal? (power-head 4 3) 64)



;; Contract: power-tail : number number -> number

;; Purpose: calculate the power of a given number using tail recursion

;; Example: (power-tail 4 3) should produce 64

;; Definition: [refines the header]

(define (power-tail b e res)
  (if (= e 0)
      res
      (power-tail b (- e 1) (* res b))))

;; Tests

(equal? (power-tail 4 3 1) 64)



;; Contract: third : list -> number

;; Purpose: returns the third element of a list

;; Example: (third '(1 2 3 4 5 6)) should produce 3

;; Definition: [refines the header]

(define (third ls aux)
  (if (null? ls)
      -1
      (if (= aux 3)
          (car ls)
          (third (cdr ls) (+ aux 1)))))

;; Tests

(equal? (third '(1 2 3 4) 1) 3)

(equal? (third (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 empty))))) 1) 3)



;; Contract: just-two : list -> boolean

;; Purpose: return true if a list contains ONLY two elements

;; Example: (just-two '(1)) should produce false

;; Example: (just-two '(1 4)) should produce true

;; Definition: [refines the header]

(define (just-two ls aux)
  (if (null? ls)
      (if (= aux 2)
          true
          false)
      (just-two (cdr ls) (+ aux 1))))

;; Tests

(equal? (just-two '(1 2) 0) #t)

(equal? (just-two (cons 1 empty) 0) #f)

(equal? (just-two (cons 1 (cons 4 empty)) 0) #t)

(equal? (just-two '() 0) #f)

(equal? (just-two '(1 2 3) 0) #f)



;; Contract: how-many-x? : list -> number

;; Purpose: return the number of elements that match x in the list

;; Example: (how-many-x? '(1 2 3 4 3) 3) should produce 2

;; Definition: [refines the header]

(define (how-many-x? lst x)
  (if (null? lst)
      0
      (cond
        [(= x (car lst)) (+ 1 (how-many-x? (cdr lst) x))]
        [else (+ 0 (how-many-x? (cdr lst) x))])))

;; Tests

(equal? (how-many-x? '(1 2 3 4 3) 3) 2)

(equal? (how-many-x? '(1 2 3 4 3) 0) 0)

(equal? (how-many-x? '(2 2 2 2 2) 2) 5)



;; Contract: all-x? : list -> boolean

;; Purpose: returns true if all elements of the list are x

;; Example: (all-x? '(2 2 2) 2) should produce true

;; Definition: [refines the header]

(define (all-x? lst x)
  (if (null? lst)
      true
      (cond
        [(= (car lst) x) (all-x? (cdr lst) x)]
        [else false])))

;; Tests

(equal? (all-x? '(2 2 2) 2) #t)

(equal? (all-x? '(2 2 1) 2) #f)



;; Contract: get : list number -> number

;; Purpose: returns the value in the given position of the least

;; Example: (get '(1 2 3 4 5) 3) should produce 3

;; Definition: [refines the header]

(define (get lst x)
  (if (= x 1)
      (car lst)
      (get (cdr lst) (- x 1))))

;; Tests

(equal? (get '(1 2 3 4 5) 3) 3)

(equal? (get '(5 4 3 2 1) 1) 5)



;; Contract: difference : list list -> list

;; Purpose: returns a list containing the elements in list A that aren't present in list B

;; Example: (difference '(1 2 3) '(3 4 5)) should produce '(3)

;; Definition: [refines the header]

(define (element-not-in-list lst x)
  (if (null? lst)
      true
      (if (= (car lst) x)
          false
          (element-not-in-list (cdr lst) x))))

(define (difference lst-A lst-B)
  (if (null? lst-A)
      empty
      (if (element-not-in-list lst-B (car lst-A))
          (cons (car lst-A) (difference (cdr lst-A) lst-B))
          (difference (cdr lst-A) lst-B))))

;; Tests

(equal? (difference '(12 44 55 77 66 1 2 3 4) '(1 2 3)) '(12 44 55 77 66 4))



;; Contract: append : list list -> list

;; Purpose: returns a list containing the elements in list A followed by the elements in list B

;; Example: (append '(a b c) '(d e f)) should produce '(a b c d e f)

;; Definition: [refines the header]

(define (append lst-A lst-B)
  (if (null? lst-A) lst-B
      (cons (car lst-A) (append (cdr lst-A) lst-B))))

;; Tests

(equal? (append '(a b c) '(d e f)) '(a b c d e f))



;; Contract: invert : list -> list

;; Purpose: inverts the order of the elements in a list

;; Example: (invert '(a b c)) should produce '(c b a)

;; Definition: [refines the header]

(define (invert lst)
  (if (null? lst)
      '()
      (append (invert (cdr lst)) (list (car lst)))))

;; Tests

(equal? (invert '(1 2 3)) '(3 2 1))



;; Contract: sign : list -> list

;; Purpose: returns a list of 1 or -1 depending on whatever each number is positive or negative

;; Example: (sign '(2 -4 -6)) should produce '(1 -1 -1)

;; Definition: [refines the header]

(define (sign lst)
  (if (null? lst)
      empty
      (cond
        [(> (car lst) 0) (cons 1 (sign (cdr lst)))]
        [else (cons -1 (sign (cdr lst)))])))

;; Tests

(equal? (sign '(2 -4 6)) '(1 -1 1))

(equal? (sign '(-10 20 -30)) '(-1 1 -1))



;; Contract: negatives : list -> list

;; Purpose: receives a list of positive integers and returns a list with corresponding negative integers

;; Example: (negatives '(2 4 6)) should produce '(-2 -4 -6)

;; Definition: [refines the header]

(define (negatives lst)
  (if (null? lst)
      empty
      (cons (* -1 (car lst)) (negatives (cdr lst)))))

;; Tests

(equal? (negatives '(2 4 6)) '(-2 -4 -6))
