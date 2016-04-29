# FP7- Checker Master

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
*Recursive Procedures
**Our procedures for completing the moves on the board, tracking game winner status, and searching for AI moves all use the recursive strategy that is conducive to the Racket language.

##External Technology and Libraries
*2htdp/image
*tcp

##Favorite Scheme Expressions
####Sean (a team member)

My favorite part of this project was writing the move function. Rather than share the entire function however, I'll display
my code that allows for a jump move. This first checks if a jump move is attempted (the distance between the start and end
coordinates must be 2), then it makes sure that the space being jumped is indeed an opponent's piece, and not your own nor a
blank space (jumpedspace gives the x and y coordinates of the space being jumped).
Once it receives the jumpedspace coordinates, it checks to make sure that the space being jumped is indeed equal to the opponent's
piece. If so, set-state performs the jump by drawing and erasing the respective spaces.

```scheme
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

####Brendan (a team member)
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
####Samir (a team member)

Each team member should identify a favorite expression or procedure, written by them, and explain what it does. Why is it your favorite? What OPL philosophy does it embody?
Remember code looks something like this:
```scheme
(map (lambda (x) (foldr compose functions)) data)
```
####Lillian (another team member)
This expression reads in a regular expression and elegantly matches it against a pre-existing hashmap....
```scheme
(let* ((expr (convert-to-regexp (read-line my-in-port)))
             (matches (flatten
                       (hash-map *words*
                                 (lambda (key value)
                                   (if (regexp-match expr key) key '()))))))
  matches)
```

##Additional Remarks
Although the server implementation is functional using localhost, it is our future plan to implement a multiplayer mode that can be played across two different computers over a TCP connection.

#How to Download and Run

To run locally download and run checkersV4.rkt from the repository.  Open the file in DrRacket and click 'Run'.  Follow the printed instructions within the REPL to play the game.

You may want to link to your latest release for easy downloading by people (such as Mark).

Include what file to run, what to do with that file, how to interact with the app when its running, etc.
