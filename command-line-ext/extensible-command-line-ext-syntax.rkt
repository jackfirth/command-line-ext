#lang racket

(require generic-syntax-expanders
         (for-syntax "core-command-line-ext-syntax.rkt"
                     generic-syntax-expanders/scoped-transformers))

(provide command-line-ext
         define-command-line-flag-expander)



(define-expander-type command-line-flag)


(define-for-syntax (identity-lens v)
  (values v values))


(define-syntax command-line-ext
  (with-scoped-pre-transformer command-line-ext-base
                               identity-lens
                               expand-all-command-line-flag-expanders))

