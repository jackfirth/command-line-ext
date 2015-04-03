#lang info

(define collection 'multi)

(define deps
  '("base"
    "rackunit-lib"
    "fancy-app"
    "generic-syntax-expanders"
    "mischief"
    "lenses"))

(define build-deps
  '("cover"
    "scribble-lib"
    "rackunit-lib"
    "package-scribblings-tools"
    "racket-doc"))
