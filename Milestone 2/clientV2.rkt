#lang racket



(define-values (in out) (tcp-connect "localhost" 9876))
(write "move game 3 5 4 4" out)
(flush-output out)
(close-input-port in)
(close-output-port out)