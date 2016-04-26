#lang racket

(require 2htdp/image)

;to start the game
;(define game (make-game))
;(draw-board (get-board game))

;example of valid move - (move game 3 5 4 4)

;server reference
;(eval (map (lambda (z) (if (string->number z) (string->number z) (string->symbol z))) (string-split "move game 3 5 4 4"))) 


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

;determines if its p1's turn (value = 1), or p2/computer's turn (value = 0)
(define p1turn 1) 

;returns the state of the current position on the board based off (x,y) coordinate I.E. blank space, p1 occupied space, etc.
(define (get-state board x y)
  (vector-ref (vector-ref board y) x))

;update the current position with the new state (i.e. turn BLANK to P1)
(define (set-state board x y state)
  (vector-set! (vector-ref board y) x state))

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
        [scene (empty-scene (* width 9) (* width 9))]) ;draws the board dimensions
        (do ((i 0 (+ i 1))) ((> i 7))
          (do ((j 0 (+ j 1))) ((> j 7))
            (set! scene (place-image (get-image board j i width) (* (+ j 0.5) width) (* (+ i 0.5) width) scene))) ;fill in the playing board
          (set! scene (place-image (text (number->string i) (quotient (* 2 width) 3.0) 'black) (* 8.5 width) (* (+ i 0.5) width) scene)) ;vertical board numbers
          (set! scene (place-image (text (number->string i) (quotient (* 2 width) 3.0) 'black) (* (+ i 0.5) width) (* 8.5 width) scene))) ;horizontal board numbers
   (display scene)
   (printf "\n")))

;used to check for jump moves
(define (jumpedspace start end) 
  (/ (+ start end) 2))

;handles moves - first checks if valid, then determines if its a jump or regular move
(define (move game start-x start-y end-x end-y)
  (define board (get-board game))
  (cond ;initial error checking
    ((or (> start-x 7) (> start-y 7) (> end-x 7) (> end-y 7) (< start-x 0) (< start-y 0) (< end-x 0) (< end-y 0)) (error "invalid coordinates"))
    ((and (= p1turn 1) (not (equal? (get-state board start-x start-y) 'P1))) (error "wrong piece, it's player one's turn!"))
    ((and (= p1turn 0) (not (equal? (get-state board start-x start-y) 'P2))) (error "wrong piece, it's player two's turn!"))
    ((not (equal? (get-state board end-x end-y) 'BLANK)) (error "destination is not a blank space"))
    (else void))

  (cond ((and (= (abs (- start-x end-x)) 1) (= (abs (- start-y end-y)) 1)) ;this is a regular move to a blank space
         (if (= p1turn 1) (set-state board end-x end-y 'P1)
             (set-state board end-x end-y 'P2))
         (set-state board start-x start-y 'BLANK))
        (else void))

  (cond ((and (= (abs (- start-x end-x)) 2) (= (abs (- start-y end-y)) 2)) ;attempting a jump move
         (cond ((and (equal? (get-state board (jumpedspace start-x end-x) (jumpedspace start-y end-y)) 'P2) (= p1turn 1)) ;p1 jumps p2
                (set-state board (jumpedspace start-x end-x) (jumpedspace start-y end-y) 'BLANK)
                (set-state board end-x end-y 'P1)
                (set-state board start-x start-y 'BLANK))
               ((and (equal? (get-state board (jumpedspace start-x end-x) (jumpedspace start-y end-y)) 'P1) (= p1turn 0)) ;p2 jumps p1
                (set-state board (jumpedspace start-x end-x) (jumpedspace start-y end-y) 'BLANK)
                (set-state board end-x end-y 'P2)
                (set-state board start-x start-y 'BLANK))
               (else (error "invalid jump move"))))
         (else void))
  
  (cond ((or (> (abs (- start-x end-x)) 2) (> (abs (- start-y end-y)) 2)) (error "invalid move")) ;you can't move a checkers piece this far in one move
        (else void))

  (if (= p1turn 1) (set! p1turn 0) (set! p1turn 1)) ;change turns
  
  (draw-board board))


;this creates the game
(define game (make-game))
(draw-board (get-board game))

(define-values (in out) (tcp-connect "localhost" 9876))
;(read-line (current-input-port) 'any)
(write (read-line (current-input-port) 'any) out)
;(write "move game 3 5 4 4" out)
(flush-output out)
(close-input-port in)
(close-output-port out)