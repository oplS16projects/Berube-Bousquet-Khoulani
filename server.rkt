#lang racket
 (require racket/tcp)


(define the-listener (tcp-listen 9876))
(define-values (in out) (tcp-accept the-listener))
(displayln (read in))
(tcp-close the-listener)
