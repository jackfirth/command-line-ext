#lang racket

(require "extensible-command-line-ext-syntax.rkt"
         "library-expanders.rkt"
         (for-syntax syntax/parse))


(define pears (make-parameter #f))
(define apples (make-parameter #f))
(define oranges (make-parameter #t))
(define current-optimization-level (make-parameter 1))


(define-command-line-flag-expander optimization-levels
  (syntax-parser
    [(_ description ...)
     #'(natural-num-param current-optimization-level
                          ("--O" "--optimize")
                          (description ...))]))


(command-line-ext
 #:program "example-script"
 #:once-each
 (toggle-params
  (pears ("-p" "--pears") "Toggles pears")
  (apples ("-a" "--apples") "Toggles apples")
  (oranges ("-o" "--oranges") "Toggles oranges"))
 #:once-any
 (optimization-levels "Includes level 2 optimizaitons"
                      "Includes level 3 optimizations"
                      "Includes level 4 optimizations"))


(define (print-fruit fruit-name good-fruit?)
  (printf "~a ~a\n"
          fruit-name
          (if good-fruit? "ROCK!" "suck")))

(define (print-optimization-level level)
  (printf "Optimization level is ~a\n" level))


(newline)
(print-fruit "Pears" (pears))
(print-fruit "Apples" (apples))
(print-fruit "Oranges" (oranges))
(newline)
(print-optimization-level (current-optimization-level))
(newline)
