#lang racket

(require "extensible-command-line-ext-syntax.rkt"
         (for-syntax syntax/parse
                     racket/list
                     fancy-app))

(provide toggle-params
         natural-num-param)



(define-command-line-flag-expander toggle-param
  (syntax-parser
    [(_ param flag-forms flag-description)
     #'(flag-forms flag-description (param (not (param))))]))


(define-command-line-flag-expander toggle-params
  (syntax-parser
    [(_ (param desc ...) ...)
     #'(begin-flags (toggle-param param desc ...) ...)]))


(define-for-syntax (add-flag-form-nums number-stx flag-forms-stx)
  (define number (syntax->datum number-stx))
  (define flag-forms (syntax->datum flag-forms-stx))
  (define append-number (string-append _ (number->string number)))
  (define flag-forms-with-nums (map append-number flag-forms))
  (datum->syntax flag-forms-stx flag-forms-with-nums))

(define-command-line-flag-expander count-param-1
  (syntax-parser
    [(_ param number:number flag-forms flag-description)
     (with-syntax ([flag-forms-with-num (add-flag-form-nums #'number #'flag-forms)])
       #'(flag-forms-with-num flag-description (param number)))]))


(define-for-syntax (make-num-description-pairs-stx descriptions-stx)
  (define num-descriptions (length (syntax->list descriptions-stx)))
  (define ns (range 2 (+ num-descriptions 2)))
  (define ns-stx (datum->syntax descriptions-stx ns))
  (syntax-parse descriptions-stx
    [(description ...)
     (with-syntax ([(n ...) ns-stx])
       #'((n description) ...))]))

(define-command-line-flag-expander natural-num-param
  (syntax-parser
    [(_ param base-flag-forms (num-description ...))
     (with-syntax ([([n description] ...) (make-num-description-pairs-stx #'(num-description ...))])
       #'(begin-flags (count-param-1 param n base-flag-forms description) ...))]))
