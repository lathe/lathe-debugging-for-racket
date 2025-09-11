#lang racket/base

; lathe-debugging/placebo
;
; Placebos of debugging utilities.

;   Copyright 2020, 2025 The Lathe Authors
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


(require
  (for-syntax
    racket/base
    (only-in syntax/parse expr this-syntax)
    lathe-debugging/private/autoptic)
  (only-in syntax/parse/define define-syntax-parse-rule))


(provide
  dlog
  dlogr)


(define-syntax-parse-rule (dlog arg:expr ... body:expr)
  #:when (autoptic-list-to? this-syntax this-syntax)
  body)

(define-syntax-parse-rule (dlogr arg:expr ... body:expr)
  #:when (autoptic-list-to? this-syntax this-syntax)
  body)
