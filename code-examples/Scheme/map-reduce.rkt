#lang racket

(define (map fn lst)
  (if (null? lst)
      '()
      (cons (fn (car lst))(map fn (cdr lst)))))

(define (reduce lst)
  (if (null? lst)
      0
      (+ (car lst) (reduce (cdr lst)))))

(reduce (map (lambda (x)(* x 50)) '(1 2 3 4)))