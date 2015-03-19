#lang racket

(require racket/cmdline
         generic-syntax-expanders
         (for-syntax syntax/parse
                     racket/function
                     fancy-app
                     racket/list
                     generic-syntax-expanders/scoped-transformers))

(define-expander-type command-line-flag)

(define-for-syntax (identity-lens v)
  (values v identity))

(begin-for-syntax
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
             (syntax->list #'(keyword spec.base-form ... ...)))))

(define-for-syntax command-line-ext-base
  (syntax-parser
    [(_ flag-clause:flag-clause-ext ... other-clause ...)
     #'(command-line flag-clause.base-form ... ... other-clause ...)]))

(define-syntax command-line-ext
  (with-scoped-pre-transformer command-line-ext-base
                               identity-lens
                               expand-all-command-line-flag-expanders))

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

(define test-flag-A (make-parameter #f))
(define test-flag-B (make-parameter #f))
(define test-flag-C (make-parameter #f))
(define optimization-level (make-parameter 1))

(command-line-ext
 #:once-each
 (toggle-params
  (test-flag-A ("-a" "--flagA") "Toggles param A")
  (test-flag-B ("-b" "--flagB") "Toggles param B")
  (test-flag-C ("-c" "--flagC") "Toggles param C"))
 #:once-any
 (natural-num-param optimization-level ("--O" "--optimize")
                    ("Includes level 2 optimizaitons"
                     "Includes level 3 optimizations"
                     "Includes level 4 optimizations")))

(printf "\nA is ~a\nB is ~a\nC is ~a\nOptimization level is ~a\n\n"
        (test-flag-A)
        (test-flag-B)
        (test-flag-C)
        (optimization-level))
