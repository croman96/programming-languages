#lang racket

;; According to https://knowyourmeme.com/memes/moon-moon
;; Moon Moon is a fictional wolf character that is portrayed as a mentally
;; challenged outcast in the pack.

;; Moon Moon wants to stop being the mentally challenged member
;; so he told his friends that he can sum all the nodes in a tree.
;; Moon Moon asked you for help because hes actually quite dumb.

;; Tree

(define t '(8(5(2)(7))(11(9)(61))))

(define q '(18(2(5)(8))(1(12)(31))))

(define x '(18(2(5)(8(55)(3)))(1(12)(31))))

;; Define if a node is a leaf or not.

(define (leaf? node)
  (null? (cdr node)))

;; Sum all the nodes in a tree.

(define (tree-sum node)
  (cond
    [(null? node) 0]
    [(leaf? node) (car node)]
    [else (+ (car node) (+ (tree-sum (car (cdr node))) (tree-sum (car (cdr (cdr node))))))]))


;; Tests

;; (tree-sum t)
;; 103

;; (tree-sum q)
;; 77

;; (tree-sum x)
;; 135





