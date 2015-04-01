#lang scribble/manual

@(require package-scribblings-tools
          (for-label command-line-ext
                     racket/cmdline
                     racket/base))

@title{Core Forms}

@defform[(command-line-ext maybe-name flag-clause ... final-clause)]{
  Like @racket[command-line], but with a few important differences.
  In addition to the normal options for @racket[flag-clause] that
  @racket[command-line] allows, a flag clause may also be of the
  form @racket[(begin-flags flag-clause ...)], which has exactly
  the same semantics as if each @racket[flag-clause] contained
  within @racket[begin-flags] was spliced into the surrounding
  list of flag clauses. Additionally, @racket[command-line-ext]
  supports @italic{command line flag expanders}, which are similar
  to @racket[match] expanders and allow a user to extend the
  grammar of @racket[flag-clause]. A custom @racket[flag-clause]
  created with @racket[define-command-line-flag-expander] can
  expand to multiple flag clauses by using @racket[begin-flags].
}
