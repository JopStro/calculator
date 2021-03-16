#lang racket

(require "calculator/calculator.rkt")
(provide (all-from-out "calculator/calculator.rkt"))

(module+ main
  (define input 
    (command-line
      #:args (expr0 . expr) (string-join (cons expr0 expr))
      )
    )
  (calc input)
  )
