#lang scribble/manual

@; lathe-debugging/scribblings/lathe-debugging.scrbl
@;
@; Debugging utilities.

@;   Copyright 2018, 2019 The Lathe Authors
@;
@;   Licensed under the Apache License, Version 2.0 (the "License");
@;   you may not use this file except in compliance with the License.
@;   You may obtain a copy of the License at
@;
@;       http://www.apache.org/licenses/LICENSE-2.0
@;
@;   Unless required by applicable law or agreed to in writing,
@;   software distributed under the License is distributed on an
@;   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
@;   either express or implied. See the License for the specific
@;   language governing permissions and limitations under the License.


@(require (for-label lathe-debugging))


@title{Lathe Debugging}

Lathe Debugging for Racket is a collection of utilities that are handy for debugging Racket code. This is a very ad hoc library, and the interface is subject to change.



@table-of-contents[]



@section[#:tag "debugging"]{Debugging utilities}

@defmodule[lathe-debugging]

@defform[
  (dlog value ...
    body)
]{
  Collects the results of the given @racket[value] expressions; logs one line to @racket[(current-output-port)] consisting of indentation, the character "@tt{\}", and those results preceded by spaces; computes the return values of the given @racket[body] expression; logs another line like the first but using "@tt{/}" instead of "@tt{\}"; and returns the computed return values.
  
  Within the dynamic extent of the body, the indentation used for other @tt{dlog} or @racket[dlogr] calls is increased by two spaces. Initially, no indentation is used.
}

@defform[
  (dlogr value ...
    body)
]{
  Collects the results of the given @racket[value] expressions; logs one line to @racket[(current-output-port)] consisting of indentation, the character "@tt{\}", and those results preceded by spaces; computes the return values of the given @racket[body] expression; logs another line like the first but using "@tt{/}" instead of "@tt{\}" and appending "@tt{ = }" and the computed return values; and returns the computed return values.
  
  Within the dynamic extent of the body, the indentation used for other @racket[dlog] or @tt{dlogr} calls is increased by two spaces. Initially, no indentation is used.
}
