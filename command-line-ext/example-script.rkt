#lang racket

(require "extensible-command-line-ext-syntax.rkt"
         "library-expanders.rkt"
         (for-syntax syntax/parse))


(define A (make-parameter #f))
(define B (make-parameter #f))
(define C (make-parameter #f))
(define current-optimization-level (make-parameter 1))


(define-command-line-flag-expander optimization-levels
  (syntax-parser
    [(_ description ...)
     #'(natural-num-param current-optimization-level
                          ("--O" "--optimize")
                          (description ...))]))


(command-line-ext
 #:once-each
 (toggle-params
  (A ("-a" "--flagA") "Toggles param A")
  (B ("-b" "--flagB") "Toggles param B")
  (C ("-c" "--flagC") "Toggles param C"))
 #:once-any
 (optimization-levels "Includes level 2 optimizaitons"
                      "Includes level 3 optimizations"
                      "Includes level 4 optimizations"))


(printf "\nA is ~a\nB is ~a\nC is ~a\nOptimization level is ~a\n\n"
        (A) (B) (C)
        (current-optimization-level))
