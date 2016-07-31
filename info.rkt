#lang info
(define collection "command-line-ext")
(define scribblings '(("main.scrbl" () (library) "command-line-ext")))
(define deps
  '("base"
    "rackunit-lib"
    "fancy-app"
    "generic-syntax-expanders"
    "reprovide-lang"
    "lens"))
(define build-deps
  '("scribble-lib"
    "rackunit-lib"
    "racket-doc"))
(define compile-omit-paths
  '("private"))
(define test-omit-paths
  '(#rx"\\.scrbl$"
    #rx"info\\.rkt$"
    #rx"util-doc\\.rkt$"))
