#lang racket
(require racket/tcp)
(require 2htdp/image)

(define the-listener (tcp-listen 9876))
(define-values (in out) (tcp-accept the-listener))
(let ((in-str (read in)))
 (begin
    (displayln in-str)
    (string? in-str)
    (eval (map (lambda (z) (if (string->number z) (string->number z) (string->symbol z))) (string-split in-str)))))
(tcp-close the-listener)



;(map (lambda (z) (if (string->number z) (string->number z) (string->symbol z))) (string-split "move game 3 3 4 5"))
;'(move game 3 3 4 5)
;> (eval (map (lambda (z) (if (string->number z) (string->number z) (string->symbol z))) (string-split "move game 3 3 4 5")))
