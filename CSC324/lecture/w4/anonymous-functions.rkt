;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname anonymous-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#| Anonymous Functions, i.e. Functions.

 E.g. Python, Javascript, Ruby,
      Lisp/Scheme/Racket, Haskell,
      Apple's C, Objective C and Swift,
      Microsoft's C#, F#, Typescript,
      Android's Kotlin,
      *modern* Java, *modern* C++, etc,
      and programming language research.

 The components of a function:
   • parameter names
   • a body expression, that can be "open" [aka "free", aka "unbound"] in the parameter names |#

; For example:
;   • n
;   • (* 2 n)
; In non-programming notation: n ↦ 2·n [n "maps to" 2·n].


; ★★★ NOTE: This file is in the "Intermediate Students with lambda" language of DrRacket.

(lambda (n) (* 2 n)) ; The doubling function.
(λ (n) (* 2 n)) ; Can write 'lambda' as 'λ' in racket.

(define (triple n) (* 2 n)) ; The doubling function, named 'triple'.
(triple (+ 100 20 3))
(triple 123)
(* 2 123) ; The name was only used to locate the parameter name(s) and body.
246

; Parameter name(s) and body are all we need when calling a function:
((λ (n) (* 2 n))
 (+ 100 20 3))

((λ (n) (* 2 n))
 123)

(* 2 123) ; Substitute into the body, as usual.

; We could name it.
(define double (λ (n) (* 2 n)))
#;(define (double n) (* 2 n))

; Function creation-and-naming is shorthand for function creation and naming.
#;(define (<function-identifier> <parameter-id> ...)
    <body-expression>)
;  is shorthand for:
#;(define <function-identifier>
    (λ (<parameter-id> ...)
      <body-expression>))

(define a-list (list 3 2 4))

(map double a-list)
(map (λ (n) (* 2 n)) (list 3 2 4)) ; Didn't really need to name the function nor list.
(list ((λ (n) (* 2 n)) 3)
      ((λ (n) (* 2 n)) 2)
      ((λ (n) (* 2 n)) 4))
(list (* 2 3)
      (* 2 2)
      (* 2 4))
(list 6 4 8)

; Some people find functions that produce functions the first
; compelling case for unnamed functions:
(define (fix-2nd f 2nd)
  #;(local [(define (f′ 1st) (f 1st 2nd))]
      f′)
  (λ (1st) (f 1st 2nd)))

#;(define fix-2nd (λ (f 2nd) (λ (1st) (f 1st 2nd))))

(fix-2nd string-append ", ")
(λ (1st) (string-append 1st ", "))

(map (fix-2nd string-append ", ") (list "chris" "matt" "pete" "jodie"))
(map (λ (1st) (string-append 1st ", ")) (list "chris" "matt" "pete" "jodie"))
(list ((λ (1st) (string-append 1st ", ")) "chris")
      ((λ (1st) (string-append 1st ", ")) "matt")
      ((λ (1st) (string-append 1st ", ")) "pete")
      ((λ (1st) (string-append 1st ", ")) "jodie"))
(list (string-append "chris" ", ")
      (string-append "matt" ", ")
      (string-append "pete" ", ")
      (string-append "jodie" ", "))

; We could of course name a specific returned result:
(define comma-space (fix-2nd string-append ", "))
#;(define comma-space (λ (1st) (string-append 1st ", ")))

(define (∘ f g)
  (λ (v) (f (g v))))
#;(define ∘ (λ (f g)
              (λ (v) (f (g v)))))

(define database
  (list (list "Ada Lovelace" 1815)
        (list "Alan Turing" 1912)
        (list "Alonzo Church" 1903)
        (list "Grace Hopper" 1906)
        (list "Kurt Goedel" 1906)))

(define name first)
(define birth second)

(filter (λ (person) (> (birth person) 1905)) database)

(filter (∘ (λ (year) (> year 1905)) birth)
        database)

(filter (∘ (fix-2nd > 1905) birth)
        database)