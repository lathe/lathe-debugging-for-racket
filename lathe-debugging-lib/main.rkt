#lang racket/base

; lathe-debugging
;
; Debugging utilities.

;   Copyright 2018 The Lathe Authors
;
;   Licensed under the Apache License, Version 2.0 (the "License");
;   you may not use this file except in compliance with the License.
;   You may obtain a copy of the License at
;
;       http://www.apache.org/licenses/LICENSE-2.0
;
;   Unless required by applicable law or agreed to in writing,
;   software distributed under the License is distributed on an
;   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
;   either express or implied. See the License for the specific
;   language governing permissions and limitations under the License.


(provide
  dlog
  dlogr)



(define nesting-indentation (make-parameter ""))

(define (w/indent body)
  (let ([indent (nesting-indentation)])
    (parameterize ([nesting-indentation (string-append indent "  ")])
      (body indent))))


(define (spaced-list lst)
  (apply string-append (map (lambda (elem) (format " ~a" elem)) lst)))


(define (dlog-shared-fn args body)
  (w/indent
    (lambda (indent)
      (define line (spaced-list args))
      (define recently-entered #f)
      (define recently-exited #f)
      (displayln (format "~a\\~a" indent line))
      (set! recently-entered #t)
      (dynamic-wind
        (lambda ()
          (unless recently-entered
            (displayln (format "~a\\[wind]~a" indent line)))
          (set! recently-entered #f))
        (lambda ()
          (with-handlers
            (
              [
                (lambda (e) #t)
                (lambda (e)
                  (displayln (format "~a/[exn]~a" indent line))
                  (set! recently-exited #t)
                  (raise e))])
            (begin0
              (body indent line)
              (set! recently-exited #t))))
        (lambda ()
          (unless recently-exited
            (displayln (format "~a/[wind]~a" indent line)))
          (set! recently-exited #f))))))


(define (dlog-fn args body)
  (dlog-shared-fn args
    (lambda (indent line)
      (begin0
        (body)
        (displayln (format "~a/~a" indent line))))))

(define-syntax-rule (dlog arg ... body)
  (dlog-fn (list arg ...) (lambda () body)))


(define (dlogr-fn args body)
  (dlog-shared-fn args
    (lambda (indent line)
      (define results (call-with-values body list))
      (define results-line (spaced-list results))
      (displayln (format "~a/~a =~a" indent line results-line))
      (apply values results))))

(define-syntax-rule (dlogr arg ... body)
  (dlogr-fn (list arg ...) (lambda () body)))
