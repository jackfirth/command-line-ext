#lang info

(define collection 'multi)

(define deps
  '("base"
    "rackunit-lib"
    "fancy-app"
    "generic-syntax-expanders"
    "mischief"))

(define build-deps
  '("cover"
    "scribble-lib"
    "rackunit-lib"
    "racket-doc"))
