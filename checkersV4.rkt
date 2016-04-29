#lang racket/base
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
    ((or (> start-x 7) (> start-y 7) (> end-x 7) (> end-y 7) (< start-x 0) (< start-y 0) (< end-x 0) (< end-y 0))
      (cond
        ((and (= p1turn 0) (not (equal? (get-state board start-x start-y) 'P2))) (error "Invalid move, and it's also player two's turn!"))
        ((and (= p1turn 1) (not (equal? (get-state board start-x start-y) 'P1))) (error "Invalid move, and it's also player one's turn!"))
        (else (error "those are invalid coordinates!!"))
      ))
    ((and (= p1turn 1) (not (equal? (get-state board start-x start-y) 'P1))) (error "wrong piece, it's player one's turn!"))
    ((and (= p1turn 0) (not (equal? (get-state board start-x start-y) 'P2))) (error "wrong piece, it's player two's turn!"))
    ((not (equal? (get-state board end-x end-y) 'BLANK))  (error "destination is not a blank space"))
    (else void))

        
  (cond ((and (= (abs (- start-x end-x)) 1) (= (abs (- start-y end-y)) 1)) ;this is a regular move to a blank space

         (for ([x (in-range 8)])
           (for ([y (in-range 8)])
             (cond
               ((and (equal? (get-state board x y) 'P1) (>= start-x 2) (>= start-y 2) (<= start-x 5)
                     (or (equal? (get-state board (+ 1 start-x) (- start-y 1)) 'P2) (equal? (get-state board (- start-x 1) (- start-y 1)) 'P2))
                     (or (equal? (get-state board (+ 2 start-x) (- start-y 2)) 'BLANK) (equal? (get-state board (- start-x 2) (- start-y 2)) 'BLANK)))
               (error "player one must make a jump move!"))
               (else void))))
         
          
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

  (if (equal? (p1-winner board) #f) ;; all P2 pieces are gone, P1 wins
      (display "\nPlayer 1 is the Winner!")
      void)
  (if (equal? (p2-winner board) #f) ;; all P1 pieces are gone, P2 wins
      (display "\nPlayer 2 is the Winner!")
      void)

  (draw-board board))


;;new stuff

(define (ai-move-easy board)
  ;; procedure will iterate thru game board for pieces belonging to the AI (Player 2)
  ;; and will then check the board for moves that are available to that piece

  ;; for/or breaks if any non-false expression is returned
  ;; the return of a #f causes the loop to continue
  (for/or ([i (in-range 8)])
;    (begin
;          (display "entering first loop...")
;          (display i)(display " "))
    (for/or ([j (in-range 8)])
;      (display "entering second loop...")
;          (begin
;            (display i)(display " ")
;            (display j)(display " "))
      (cond
            ((equal? (get-state board i j) 'P2)
             (cond  
               
               ((and (< i 8)
                     (< (+ i 2) 8)
                     (< j 6)
                     (equal? (get-state board (+ i 2) (+ j 2)) 'BLANK)) ;jump move right, 1st case
                (if (equal? (get-state board (jumpedspace i (+ i 2)) (jumpedspace j (+ j 2))) 'P1)
;                    (begin (move game i j (+ i 2) (+ j 2))
;                           (display "tripped 1st case...")
;                           (display i)(display " ")
;                           (display j)(display " "))
                    (move game i j (+ i 2) (+ j 2))
                    #f))

               ((and (> i 1);; changed from 0
                     (>= (- i 2) 0)
                     (< j 6)
                     (equal? (get-state board (- i 2) (+ j 2)) 'BLANK)) ;jump move left, 2nd case
                (if (equal? (get-state board (jumpedspace i (- i 2)) (jumpedspace j (+ j 2))) 'P1)
;                    (begin (move game i j (- i 2) (+ j 2))
;                           (display "tripped 2nd case...")
;                           (display i)(display " ")
;                           (display j)(display " "))
                    (move game i j (- i 2) (+ j 2))
                    #f))

               ((and (< i 7)
                     (< j 7)
                     (equal? (get-state board (+ i 1) (+ j 1)) 'BLANK)) ;reg move right, 3rd case
;                (begin (move game i j (+ i 1) (+ j 1))
;                (display "tripped 3rd case...")
;                (display i)(display " ")
;                (display j)(display " "))
                (move game i j (+ i 1) (+ j 1)))

               ((and (> i 0)
                     (< j 7)
                     (equal? (get-state board (- i 1) (+ j 1)) 'BLANK)) ;reg move left, 4th case
;                (begin (move game i j (- i 1) (+ j 1))
;                (display "tripped 4th case...")
;                (display i)(display " ")
;                (display j)(display " "))
                (move game i j (- i 1) (+ j 1)))


               (else #f)))
       (else #f)))))

(define (ai-move-hard board)
  ;; procedure will iterate thru game board for pieces belonging to the AI (Player 2)
  ;; and will then check the board for moves that are available to that piece

  ;; for/or breaks if any non-false expression is returned
  ;; the return of a #f causes the loop to continue
  (for/or ([i (in-range 7 -1 -1)])
;    (begin
;          (display "entering first loop...")
;          (display i)(display " "))
    (for/or ([j (in-range 7 -1 -1)])
;      (display "entering second loop...")
;          (begin
;            (display i)(display " ")
;            (display j)(display " "))
      (cond
            ((equal? (get-state board i j) 'P2)
             (cond

          
               ;checking for double jump down left-right possibility without using move proc
               ((and (< (+ i 2) 8)
                     (>= i 1)
                     (<= j 3)
                     (equal? (get-state board (- i 1) (+ j 1)) 'P1)
                     (equal? (get-state board (- i 1) (+ j 3)) 'P1))
                (if (and (equal? (get-state board (- i 2) (+ 2 j)) 'BLANK)
                         (equal? (get-state board i (+ j 4)) 'BLANK))
                    ((lambda args (set-state board i j 'BLANK)
                       (set-state board (- i 1) (+ j 1) 'BLANK) ; first piece to be jumped
                       (set-state board (- i 1) (+ j 3) 'BLANK) ; second piece to be jumped
                       (set-state board i (+ j 4) 'P2)))        ; where AI lands after jumping two pieces
                    #f))

               ;checking for double jump down right-left possibility without using move proc
               ((and (< (+ i 3) 8)
                     (>= i 1)
                     (<= j 3)
                     (equal? (get-state board (+ i 1) (+ j 1)) 'P1)
                     (equal? (get-state board (+ i 1) (+ j 3)) 'P1))
                (if (and (equal? (get-state board (+ i 2) (+ 2 j)) 'BLANK)
                         (equal? (get-state board i (+ j 4)) 'BLANK))
                    ((lambda args (set-state board i j 'BLANK)
                       (set-state board (+ i 1) (+ j 1) 'BLANK) ; first piece to be jumped
                       (set-state board (+ i 3) (+ j 3) 'BLANK) ; second piece to be jumped
                       (set-state board (+ i 4) (+ j 4) 'P2)))  ; where AI lands after jumping two pieces
                    #f))


                ;checking for double jump down diag-right possibility without using move proc
               ((and (< (+ i 4) 8)
                     (< (+ j 4) 8)
                     (equal? (get-state board (+ i 1) (+ j 1)) 'P1)
                     (equal? (get-state board (+ i 1) (+ j 3)) 'P1))
                (if (and (equal? (get-state board (+ i 2) (+ 2 j)) 'BLANK)
                         (equal? (get-state board i (+ j 4)) 'BLANK))
                    ((lambda args (set-state board i j 'BLANK)
                       (set-state board (+ i 1) (+ j 1) 'BLANK) ; first piece to be jumped
                       (set-state board (+ i 3) (+ j 3) 'BLANK) ; second piece to be jumped
                       (set-state board (+ i 4) (+ j 4) 'P2)))  ; where AI lands after jumping two pieces
                    #f))

              

               ;checking for double jump down diag-left possibility without using move proc
               ((and (>= (- i 4) 0)
                     (< (+ j 4) 8)
                     (equal? (get-state board (- i 1) (+ j 1)) 'P1)
                     (equal? (get-state board (- i 3) (+ j 3)) 'P1))
                (if (and (equal? (get-state board (- i 2) (+ j 2)) 'BLANK)
                         (equal? (get-state board (- i 4) (+ j 4)) 'BLANK))
                    ((lambda args (set-state board i j 'BLANK)
                       (set-state board (- i 1) (+ j 1) 'BLANK) ; first piece to be jumped
                       (set-state board (- i 3) (+ j 3) 'BLANK) ; second piece to be jumped
                       (set-state board (- i 4) (+ j 4) 'P2)))  ; where AI lands after jumping two pieces
                    #f))


               ;checking if ai can jump down right
               ((and (< i 8) 
                     (< (+ i 2) 8)
                     (< j 6)
                     (>= i 1)
                     (<= j 5)
                     (equal? (get-state board (+ 1 i) (+ j 1)) 'P1))
                (if (equal? (get-state board (+ 2 i) (+ 2 j)) 'BLANK)
                    (move game i j (+ 2 i) (+ 2 j))
                    #f))

               
               ;checking if ai can jump down left
               ((and (< i 8) 
                     (< (+ i 2) 8)
                     (< j 6)
                     (>= i 1)
                     (<= j 5)
                     (equal? (get-state board (- i 1) (+ j 1)) 'P1))
                (if (equal? (get-state board (+ i 2) (+ 2 j)) 'BLANK)
                    (move game i j (- i 2) (+ 2 j))
                    #f))
               

               ((and (< i 8)
                     (< (+ i 2) 8)
                     (< j 6)
                     (equal? (get-state board (+ i 2) (+ j 2)) 'BLANK)) ;jump move right, 1st case
                (if (equal? (get-state board (jumpedspace i (+ i 2)) (jumpedspace j (+ j 2))) 'P1)
;                    (begin (move game i j (+ i 2) (+ j 2))
;                           (display "tripped 1st case...")
;                           (display i)(display " ")
;                           (display j)(display " "))
                    (move game i j (+ i 2) (+ j 2))
                    #f))

               ((and (> i 1);; changed from 0
                     (> (- i 2) 0)
                     (< j 6)
                     (equal? (get-state board (- i 2) (+ j 2)) 'BLANK)) ;jump move left, 2nd case
                (if (equal? (get-state board (jumpedspace i (- i 2)) (jumpedspace j (+ j 2))) 'P1)
;                    (begin (move game i j (- i 2) (+ j 2))
;                           (display "tripped 2nd case...")
;                           (display i)(display " ")
;                           (display j)(display " "))
                    (move game i j (- i 2) (+ j 2))
                    #f))

               ((and (< i 7)
                     (< j 7)
                     (equal? (get-state board (+ i 1) (+ j 1)) 'BLANK)) ;reg move right, 3rd case
;                (begin (move game i j (+ i 1) (+ j 1))
;                (display "tripped 3rd case...")
;                (display i)(display " ")
;                (display j)(display " "))
                (move game i j (+ i 1) (+ j 1)))

               ((and (> i 0)
                     (< j 7)
                     (equal? (get-state board (- i 1) (+ j 1)) 'BLANK)) ;reg move left, 4th case
;                (begin (move game i j (- i 1) (+ j 1))
;                (display "tripped 4th case...")
;                (display i)(display " ")
;                (display j)(display " "))
                (move game i j (- i 1) (+ j 1)))


               (else #f)))
       (else #f)))))

(define (p1-winner board)      ;;returns true if P2 pieces still exist, meaning P1 has not won yet
  (for/or ([i (in-range 8)])   ;;(written this way because for/or will terminate when returned #t,
    (for/or ([j (in-range 8)]) ;;so that the search will stop when the first P2 piece is found.
      (cond                    ;;if #f is returned then there are no P2 pieces and P1 has won.
        [(equal? (get-state board i j) 'P2)
         #t]
        [else
         #f]))))

(define (p2-winner board)      ;;returns true if P1 pieces still exist, meaning P2 has not won yet
  (for/or ([i (in-range 8)])   ;;(written this way because for/or will terminate when returned #t,
    (for/or ([j (in-range 8)]) ;;so that the search will stop when the first P1 piece is found.
      (cond                    ;;if #f is returned then there are no P1 pieces and P2 has won.
        [(equal? (get-state board i j) 'P1)
         #t]
        [else
         #f]))))

;this creates the game
(define game (make-game))
(draw-board (get-board game))
(begin
  (display "To Make Player Moves:")
  (display "\n(move game start-x start-y end-x end-y)")
  (display "\n\nTo Make AI Moves:")
  (display "\n(ai-move-easy (get-board game))")
  (display "\nfor easy mode AI.")
  (display "\n\n(ai-move-hard (get-board game))")
  (display "\nfor hard mode AI."))
