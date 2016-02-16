#lang info

(define collection 'multi)

(define deps
  '("base"
    "rackunit-lib"
    "fancy-app"
    "generic-syntax-expanders"
    "reprovide-lang"
    "lens"))

(define build-deps
  '("cover"
    "cover-coveralls"
    "scribble-lib"
    "rackunit-lib"
    "git://github.com/jackfirth/package-scribblings-tools"
    "racket-doc"))
