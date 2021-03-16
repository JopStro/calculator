#lang racket


(provide (contract-out [calc (-> string? number?)]))

(define (op-in-expr? op expr) (regexp-match? (regexp (string-append " *" (regexp-quote (symbol->string op)) " *")) expr))
(define (split-expr op expr) (regexp-split (regexp (string-append " *" (regexp-quote (symbol->string op)) " *")) expr))
(define-syntax evaluate (syntax-rules ()
			  [(evaluate expr)
			   (string->number expr)]
			  [(evaluate expr op0 op ...)
			   (if (op-in-expr? 'op0 expr) 
			     (apply op0 (for/list ([split (in-list (split-expr 'op0 expr))]) (evaluate split op ...)))
			     (evaluate expr op ...))]))
(define (calc expr)
  (evaluate expr + - * /))
