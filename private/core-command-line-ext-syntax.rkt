#lang racket

(require syntax/parse
         (for-template racket/cmdline))

(provide command-line-ext-base)



(define-syntax-class flag-spec-ext
  #:datum-literals (begin-flags)
  #:attributes ((base-form 1))
  (pattern (~or (begin-flags sub-flag-spec:flag-spec-ext ...)
                simple-spec)
           #:attr (base-form 1)
           (if (attribute simple-spec)
               (list #'simple-spec)
               (syntax->list #'(sub-flag-spec.base-form ... ...)))))


(define-syntax-class flag-clause-keyword
  (pattern (~or #:multi #:once-each #:once-any #:final)))


(define-splicing-syntax-class flag-clause-ext
  #:attributes ((base-form 1))
  (pattern (~seq keyword:flag-clause-keyword
                 spec:flag-spec-ext ...)
           #:attr (base-form 1)
           (syntax->list #'(keyword spec.base-form ... ...))))


(define-splicing-syntax-class flag-clauses-ext
  #:attributes ((base-form 1))
  (pattern (~seq clause:flag-clause-ext ...)
           #:attr (base-form 1)
           (syntax->list #'(clause.base-form ... ...))))


(define command-line-ext-base
  (syntax-parser
    [(_ #:program name flag-clauses:flag-clauses-ext other-clause ...)
     #'(command-line #:program name flag-clauses.base-form ... other-clause ...)]
    [(_ flag-clauses:flag-clauses-ext other-clause ...)
     #'(command-line flag-clauses.base-form ... other-clause ...)]))
