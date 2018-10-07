#lang info

(define collection "lathe-debugging")

(define deps (list "base"))
(define build-deps
  (list "lathe-debugging-lib" "racket-doc" "scribble-lib"))

(define scribblings
  (list (list "scribblings/lathe-debugging.scrbl" (list))))
