#lang info

(define collection 'multi)

(define deps
  '("base"
    "rackunit-lib"
    "fancy-app"
    "generic-syntax-expanders"
    "mischief"
    "lens"))

(define build-deps
  '("cover"
    "cover-coveralls"
    "scribble-lib"
    "rackunit-lib"
    "package-scribblings-tools"
    "racket-doc"))
