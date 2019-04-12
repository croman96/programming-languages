#lang racket

;; Contract: deep-all-x? : list number -> boolean

;; Purpose: return true if every element of the list is x.

;; Example: (deep-all-x? '(7 (7 7) 7(7 (7 7) 7)) 7) should produce true.

;; Definition: [refines the header]

(define (deep-all-x? lst x)
    (cond
      [(null? lst) true]
      [else (and (check-x (car lst) x) (deep-all-x? (cdr lst) x))]))

(define (check-x lst x)
  (cond
    [(list? lst) (deep-all-x? lst x)]
    [else 
     (cond
       [(= lst x) true]
       [else false])]))

;; Tests

(equal? (deep-all-x? '(7 (7 7) 7(7 (7 7) 7)) 7) #t)

(equal? (deep-all-x? '(7 (7 7) 7(7 (1 7) 7)) 7) #f)



;; Contract: deep-reverse : list -> list

;; Purpose: returns a list of lists with its elements in reverse order.

;; Example: (deep-reverse '(a (b (c d)) e (f g))) should produce ((g f) e ((d c) b) a)

;; Definition: [refines the header]

(define (deep-reverse A)
  (reverse A '()))

(define (reverse A B)     
  (cond
    [(empty? A) B]
    [(list? (car A)) (reverse (cdr A) (cons (reverse (car A) '()) B))]
    [else (reverse (cdr A) (cons (car A) B))]))

;; Tests

(equal? (deep-reverse '(a (b (c d)) e (f g))) '((g f) e ((d c) b) a))



;; Contract: flatten : list -> list

;; Purpose: returns a list containing all the elements in a single 1 level list.

;; Example: (flatten '(a (b (c d)) e (f g))) should produce (a b c d e f g)

;; Definition: [refines the header]

(define (flatten A)
  (flat A '()))

(define (flat A B)     
  (cond
    [(empty? A) B]
    [(list? (car A)) (flat (car A) (flat (cdr A) B))]
    [else (cons (car A) (flat (cdr A) B))]))

;; Tests

(equal? (flatten '(a (b (c d)) (e (f g)))) '(a b c d e f g))



;; Contract: count-levels : list -> number

;; Purpose: returns the max depth of a tree.

;; Example: (count-levels '(a (b (c) (d)) e (f) (g))) should produce 3

;; Definition: [refines the header]

(define (count-levels A)
  (if (empty? A)
    0
    (if (empty? (cdr A))
        1
        (+ 1 (levels (cdr A))))))

(define (levels A)
  (if (empty? A)
    0
    (max (count-levels(car A)) (levels(cdr A)))))

;; Tests

(equal? (count-levels '(a (b (c) (d)) (e (f) (g)))) 3)

(equal? (count-levels '(a (b (c (d) (e)) (f))(g (h) (i)))) 4)



;; Contract: count-max-arity : list -> number

;; Purpose: returns the max number of children a single node of the tree has.

;; Example: (count-max-arity '(a (b (c) (d)) (e (f) (g) (h) (i)))) should produce 4

;; Definition: [refines the header]

(define (children lst)
  (cdr lst))

(define (arity lst)
  (if (list? lst)
      (max (- (length lst) 1) (count-max-arity (children lst)))
      0))

(define (count-max-arity lst)
  (if (null? lst)
      0
      (max (arity (car lst))
         (count-max-arity (cdr lst)))))

;; Tests

(equal? (count-max-arity '(a (b (c) (d)) (e (f) (g) (h) (i)))) 4)

(equal? (count-max-arity '(a (b (c) (d)) (e (f) (g) (i)))) 3)

(equal? (count-max-arity '(a (b (c) (d)) (e (f) (g) (i (j) (k) (l) (m) (n))))) 5)
