#lang scribble/manual

@(require scribble/eval
          (for-label command-line-ext
                     racket/base))

@(define the-eval (make-base-eval))
@(the-eval '(require "main.rkt"))

@title{Extensible Command Line}

@defmodule[command-line-ext]

@author[@author+email["Jack Firth" "jackhfirth@gmail.com"]]

source code: @url["https://github.com/jackfirth/command-line-ext"]
