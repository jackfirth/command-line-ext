#lang at-exp racket/base

(provide (for-label (all-from-out command-line-ext))
         defpredicate
         command-line-examples
         source-code)

(require (for-label command-line-ext
                    racket/base
                    racket/contract)
         scribble/example
         scribble/manual
         scribble/text)


(define requirements
  '(command-line-ext))

(define (make-eval)
  (make-base-eval #:lang 'racket/base
                  (cons 'require requirements)))

(define-syntax-rule (command-line-examples example ...)
   (examples #:eval (make-eval) example ...))

(define-syntax-rule (defpredicate id pre-flow ...)
  (defthing #:kind "procedure" id predicate/c pre-flow ...))

(define (source-code dest-url)
  @begin/text{Source code is available at @url[dest-url]})
