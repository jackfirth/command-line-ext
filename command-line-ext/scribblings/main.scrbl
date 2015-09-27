#lang scribble/manual

@(require package-scribblings-tools
          (for-label command-line-ext
                     racket/cmdline
                     racket/base))

@module-title[command-line-ext]{Extensible Command Line}
@author[@author+email["Jack Firth" "jackhfirth@gmail.com"]]

This library defines a more extensible version of @racket[command-line]
that supports @italic{command line flag expanders}, allowing users to
abstract over common command line flag patterns. This library also
comes batteries-included with many pre-defined expanders for commmon
patterns such as switches that toggle boolean parameters.

@source-code{https://github.com/jackfirth/command-line-ext}

@include-section["core-form.scrbl"]
