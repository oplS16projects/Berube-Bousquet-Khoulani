#lang racket
(require 2htdp/image)

;make the board, each symbol will be used to tell the library what to draw
;(i.e. BLANK = draw empty red space, OFF = draw black space, P1/P2 = player occupied space)
(define (make-board)
  (vector
   (list->vector '(P2 OFF P2 OFF P2 OFF P2 OFF))
   (list->vector '(OFF P2 OFF P2 OFF P2 OFF P2))
   (list->vector '(P2 OFF P2 OFF P2 OFF P2 OFF))
   (list->vector '(OFF BLANK OFF BLANK OFF BLANK OFF BLANK))
   (list->vector '(BLANK OFF BLANK OFF BLANK OFF BLANK OFF))
   (list->vector '(OFF P1 OFF P1 OFF P1 OFF P1))
   (list->vector '(P1 OFF P1 OFF P1 OFF P1 OFF))
   (list->vector '(OFF P1 OFF P1 OFF P1 OFF P1))))

;gives the state of the current position on the board based off (x,y) coordinate I.E. blank space, p1 occupied space, etc.
(define (get-state board x y)
  (vector-ref (vector-ref board y) x))

;used to make an instance of "game"
(define (make-game)
  (vector (make-board) 'P1))

;uses vector-ref to fetch the game board
(define (get-board game)
  (vector-ref game 0))

;make black rectangles (won't be played on)
(define (OFF width)
  (rectangle width width 'solid 'black))

;empty red rectangle (no pieces on it)
(define (BLANK width)
  (rectangle width width 'solid 'red ))

;player 1 pieces - solid black circle over red rectangle
(define (P1 width)
  (overlay (circle (/ (* 3 width) 8) 'solid 'black)
           (BLANK width)))

;player 2 pieces - red circle over black circle over red rectangle (by appearance it resembles a black circle filled with red in center)
(define (P2 width)
  (overlay (circle (/ (* 4 width) 14) 'solid 'red)
  (overlay (circle (/ (* 3 width) 8) 'solid 'black)
           (BLANK width))))


;determine whether to print a black space, empty red space, or p1/p2 occupied red space
(define (get-image board x y width)
  (cond [(equal? (get-state board x y) 'OFF) (OFF width)]
        [(equal? (get-state board x y) 'BLANK) (BLANK width)]
        [(equal? (get-state board x y) 'P1) (P1 width)]
        [(equal? (get-state board x y) 'P2) (P2 width)]))

;draw board with horizontal and vertical numbers as reference points when client enters a move
;ex- should be able to do something like (move 4 3 5 2) where the first 2 params are the original coordinates and the last 2 are the space to move to
(define (draw-board board)
  (let* ([width 48]
        [scene (empty-scene (* width 9) (* width 9))]) ;draws the board dimension s
        (do ((i 0 (+ i 1))) ((> i 7))
          (do ((j 0 (+ j 1))) ((> j 7))
            (set! scene (place-image (get-image board j i width) (* (+ j 0.5) width) (* (+ i 0.5) width) scene))) ;fill in the playing board
          (set! scene (place-image (text (number->string i) (quotient (* 2 width) 3.0) 'black) (* 8.5 width) (* (+ i 0.5) width) scene)) ;vertical board numbers
          (set! scene (place-image (text (number->string i) (quotient (* 2 width) 3.0) 'black) (* (+ i 0.5) width) (* 8.5 width) scene))) ;horizontal board numbers
   (display scene)
   (printf "\n")))