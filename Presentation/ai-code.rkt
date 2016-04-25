#lang racket
(require 2htdp/image)
(include "checkersV2.rkt")

;; AI player will act as player 2

(define (ai-moves board difficulty)
  (cond
    [(if (= p1turn 1)(error "wrong piece, it's player one's turn!"))
     (equal? difficulty easy)
     ;;identify set of possible moves
     ;;randomly select a move
     ;; OR
     ;;try moves and then run them through the validation code
     ;;until succeeds

     
     
    (if (= p1turn 1) (set! p1turn 0) (set! p1turn 1)) ;change turns
  
  (draw-board board))