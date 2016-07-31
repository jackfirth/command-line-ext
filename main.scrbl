#lang scribble/manual
@(require "private/doc-util.rkt")

@title{Extensible Command Line}
@defmodule[command-line-ext]
@author[@author+email["Jack Firth" "jackhfirth@gmail.com"]]

This library defines a more extensible version of @racket[command-line]
that supports @emph{command line flag expanders}, allowing users to
abstract over common command line flag patterns. This library also
comes batteries-included with many pre-defined expanders for commmon
patterns such as switches that toggle boolean parameters.

@source-code{https://github.com/jackfirth/command-line-ext}

@include-section["private/core-form.scrbl"]
