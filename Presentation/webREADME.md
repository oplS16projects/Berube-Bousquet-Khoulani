#Checker Master

##Authors
Sean Berube

Samir Khoulani

Brendan Bousquet

##Overview
Checker Master is a checkers game implemented in Racket. The game, complete with a custom UI, is able to handle 3 modes of gameplay: Human v. Human, Human v. Easy AI, Human v. Hard AI.

##Screenshot
(insert a screenshot here. You may opt to get rid of the title for it. You need at least one screenshot. Make it actually appear here, don't just add a link.)

Here's a demonstration of how to display an image that's uploaded to this repo:
![screenshot showing env diagram](withdraw.png)

##Concepts Demonstrated
* Recursive Procedures
  * Our procedures for completing the moves on the board, tracking game winner status, and searching for AI moves all use the recursive strategy that is conducive to the Racket language.

##External Technology and Libraries
* 2htdp/image
* tcp

##Favorite Scheme Expressions
####Sean (a team member)
####Brendan (a team member)
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

##Additional Remarks
Although the server implementation is functional using localhost, it is our future plan to implement a multiplayer mode that can be played across two different computers over a TCP connection.

#How to Download and Run

To run locally download and run checkersV4.rkt from the repository.  Open the file in DrRacket and click 'Run'.  Follow the printed instructions within the REPL to play the game.
