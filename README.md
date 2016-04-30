#Checker Master

##Authors

Sean Berube

Samir Khoulani

Brendan Bousquet

##Overview
Checker Master is a checkers game implemented in Racket. The game, complete with a custom UI, is able to handle 3 modes of gameplay: Human v. Human, Human v. Easy AI, Human v. Hard AI.

##Screenshot

![game-board](https://github.com/oplS16projects/Berube-Bousquet-Khoulani/blob/master/checkerboard.PNG)

##Concepts Demonstrated
Identify the OPL concepts demonstrated in your project. Be brief. A simple list and example is sufficient.
* Recursive Procedures
* Our procedures for completing the moves on the board, tracking game winner status, and searching for AI moves all use the recursive strategy that is conducive to the Racket language.

##External Technology and Libraries
* 2htdp/image
* tcp

##Favorite Scheme Expressions
####Sean

My favorite part of this project was writing the move function. Rather than share the entire function however, I'll display
my code that allows for a jump move. This first checks if a jump move is attempted (the distance between the start and end
coordinates must be 2), then it makes sure that the space being jumped is indeed an opponent's piece, and not your own nor a
blank space (jumpedspace gives the x and y coordinates of the space being jumped).
Once it receives the jumpedspace coordinates, it checks to make sure that the space being jumped is indeed equal to the opponent's
piece. If so, set-state performs the jump by drawing and erasing the respective spaces.

```Racket
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
```

####Brendan
My favorite little bit of code I wrote was the procedure that detects a player winning the game.  It makes a unique use of the for/or loop procedure that will proceed to loop through the given iterations until it returns a non-false.  This allowed me to traverse through the board until I found an opponent piece(there is no win yet) or until the whole board is traverse(there is a win).
```Racket
(define (p1-winner board)          ;;returns true if P2 pieces still exist, meaning P1 has not won yet
  (for/or ([i (in-range 8)])       ;;(written this way because for/or will terminate when returned #t,
    (for/or ([j (in-range 8)])     ;;so that the search will stop when the first P2 piece is found.
      (cond                        ;;if #f is returned then there are no P2 pieces and P1 has won.
        [(equal? (get-state board i j) 'P2)
         #t]
        [else
         #f]))))
```
####Samir
This one took a little bit of whiteboarding pseudocode, but the result is my favorite bit of code that implements a functionality for the advanced AI: If a checkers piece can jump an enemy piece, it has to jump it, no exceptions! The code basically checks if, before a non-jump move is made, there exists a jumpable piece. If so, it must be jumped. It returns an error if the player tries avoiding the jump move.

```Racket
(for ([x (in-range 8)])
           (for ([y (in-range 8)])
             (cond
               ((and (equal? (get-state board x y) 'P1) (>= start-x 2) (>= start-y 2) (<= start-x 5)
                     (or (equal? (get-state board (+ 1 start-x) (- start-y 1)) 'P2) (equal? (get-state board (- start-x 1) (- start-y 1)) 'P2))
                     (or (equal? (get-state board (+ 2 start-x) (- start-y 2)) 'BLANK) (equal? (get-state board (- start-x 2) (- start-y 2)) 'BLANK)))
               (error "player one must make a jump move!!"))
               (else void))))
```

##Additional Remarks
Although the server implementation is functional using localhost, it is our future plan to implement a multiplayer mode that can be played across two different computers over a TCP connection.

#How to Download and Run

To run locally download, or click [here](checkersV4.rkt), and run checkersV4.rkt from the repository.  Open the file in DrRacket and click 'Run'.  Follow the printed instructions within the REPL to play the game.
