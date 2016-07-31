#lang racket

(require generic-syntax-expanders
         (for-syntax "core-command-line-ext-syntax.rkt"
                     unstable/lens
                     generic-syntax-expanders))

(provide command-line-ext
         define-command-line-flag-expander)


(define-expander-type command-line-flag)

(define-for-syntax multi-lens (syntax-keyword-seq-lens '#:multi))
(define-for-syntax once-each-lens (syntax-keyword-seq-lens '#:once-each))
(define-for-syntax once-any-lens (syntax-keyword-seq-lens '#:once-any))
(define-for-syntax final-lens (syntax-keyword-seq-lens '#:final))

(define-for-syntax flag-spec-lenses
  (list multi-lens
        once-each-lens
        once-any-lens
        final-lens))


(define-for-syntax (identity-lens v)
  (values v values))


(define-syntax command-line-ext
  (let ()
    (define with-once-each-flags
      (with-scoped-pre-transformer command-line-ext-base
                                   once-each-lens
                                   expand-all-command-line-flag-expanders))
    (define with-once-any-flags
      (with-scoped-pre-transformer with-once-each-flags
                                   once-any-lens
                                   expand-all-command-line-flag-expanders))
    (define with-multi-flags
      (with-scoped-pre-transformer with-once-any-flags
                                   multi-lens
                                   expand-all-command-line-flag-expanders))
    (define with-final-flags
      (with-scoped-pre-transformer with-multi-flags
                                   final-lens
                                   expand-all-command-line-flag-expanders))
    with-final-flags))
