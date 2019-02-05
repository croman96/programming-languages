#lang racket

(define t '(8(5(2)(7))(11(9)(61))))

(define (leaf? node)
  (null? (cdr node)))

(define (bst-has? node val)
  (cond
    [(null? node) false]
    [(= (car node) val) true]
    [(leaf? node) false]
    [(> (car node) val) (bst-has? (car (cdr node)) val)]
    [else (bst-has? (car (cdr (cdr node))) val)]))

(bst-has? t 8)
; #t

(bst-has? t 61)
; #t

(bst-has? t 9)
; #t

(bst-has? t 100)
; #f

(bst-has? t -100)
; #f

(bst-has? t 7)
; #t

