# FP7-webpage Title of Project
This is a template for using your repo's README.md as your project web page.
I recommend you copy and paste into your README file. Delete this line and the one above it, customize everything else. Make it look good!

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
Identify the OPL concepts demonstrated in your project. Be brief. A simple list and example is sufficient.
*Recursive Procedures
**Our procedures for completing the moves on the board, tracking game winner status, and searching for AI moves all use the recursive strategy that is conducive to the Racket language.

##External Technology and Libraries
*2htdp/image
*tcp

##Favorite Scheme Expressions
####Sean (a team member)
####Brendan (a team member)
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