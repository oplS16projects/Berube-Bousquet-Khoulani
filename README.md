# Project Title: Checker Master

### Statement
In this project we will create an interactive checker game that can be played in a 1 or 2 player mode.  The 2 player mode will be a simple implementation of two human-controller clients talking to a server that verifies the validity of the moves taken.  The interesting portion will be in the 1 player mode where the human-controlled client is playing against an AI-controlled client.  This AI will have two settings of difficulty, one of which behaving like an intuitive human player, and the other will try to play a "perfect game", against which the best outcome is a draw.  We hope to learn about building a client-server interface, as well as how to build algorithms that will simulate certain player skill.

### Analysis
Much of this project will consist of recursive procedures.  Many of the algorithms designed to "solve" games have a recursive nature to them which is why the project is suitable for Racket.  We will make use of object orientation, particularly in the front-end portion of the program where we will have board and checker piece objects that will need handling.  The map/filter/reduce procedures may also prove useful in perhaps searching through a list of potential moves within the AI logic.  (Insert info here regarding client-server interface)

### Data set or other source materials
We will be using at the very least the visuals (game board and piece image drawing) and simple structure (a class involving the drawing and structure of the board) of the in-language Racket simple checkers game (with no AI player) to help implement the front end of the program.  This is in the games/gl-board-game library.

In addition to this we will be using whatever resources that can be found regarding the solved checker algorithm from the University of Alberta who originally solved it.  Their method uses databases consisting of opening moves and strategies from checker masters rather than just a logical algorithm so if any of those databases are public that would be the best possible implementation.  However many of their resources are unavailable (lots of 404 errors on their pages) so there may be a need for other research sources to construct a "perfect" AI player.

### Deliverable and Demonstration
Ideally we will have an interactive program that will be able to: have two human-controlled clients play eachother via the server from different machines, have a human-controlled client play an AI-controlled client that behaves similarly to a human player, and have a human-controlled client play an AI-controlled client that will play such that the best the human player can do is tie the AI player.

There is the possibility that this last objective will not be achievable with the resources available, however it is most likely that an AI that plays a nearly perfect game is certainly achievable do to the non-complicated nature of the game of checkers.

We will at the time of the demonstration be able to show the program working in all of these three capacities to the class.  In order to speed up the demonstration of the perfect game we may have to show a partially completed game finishing with a tie or demonstrate in some way how the AI plays in a strategically perfect way.

### Evaluation of Results
We can demonstrate our success by showing that a game can be completed successfully (meaning all moves follow the rules of checkers) between two humans, and between a human and both of the AI's repectively.  However we would be left with the issue of how good the AI's are comparatively.  We can show the "perfect" AI is better than the "human" AI by creating an interface in which the two AI clients are connected to a server to play a game against one another.  In this situation the "perfect" AI will beat the "human" AI every time.  That way the AI's can be considered objectively successful in the manner in which they are constructed.

## Architecture Diagram
![Architecture Diagram Gliffy Link](http://www.gliffy.com/go/publish/image/10360779/L.png)
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
### First Milestone (Fri Apr 15)
Client-server architecture has been set up.  Front-end will be at the very least functional and display the game board and will be able to draw pieces to hard coded spots.  Server work to verify these moves should be working for obvious cases.  The two player system will possibly completed based on how quickly the previous tasks are completed. The algorithms for both AI clients will be under development at this time.

### Second Milestone (Fri Apr 22)
Server will be properly verifying moves, with edge cases considered.  Front-end will be complete as far as visual interface.  Two player mode should be functional.  The server should also allow for a human-controlled client to play against an AI cliet so that testing of the AI algorithms can happen easier.  The AI clients should be at the very least in prototype stage where they can be played against by a human-controlled client with some demonstration of functionality.  The two AI's should be discernable at this stage already even if the smarter AI is not perfect yet.  Work should begin that will allow these two AI's to be played against eachother in some capacity to demonstrate their effectiveness in the final presentation.

### Final Presentation (last week of semester)
By this point the two AI's should now be functional enough to be played against fluidly by human players.  The server should also now support the functionality of playing the two AI's against eachother so that it can be shown that they superior AI wins every time.  This will be implemented in whichever way is the most effiencient based on the client-server implementation.  

## Group Responsibilities
### Samir Khoulani @skhoulani
will write the....

### Brendan Bousquet @brendanbousquet
will be responsible for contructing the smarter of the two AI.  Samir will likely assist with this once his AI is done toward the tail end of the project timeline.  Brendan will be tasked with finding methods to test the functionality of the AI after it has been developed.  Brendan will assist with some of the front end work while the research and initial implementation is being constructed for the AI.

### Sean Berube @sberube484
Sean is team lead. He will be working on the front end and will implement the 2-player mode. He will also work on implementing a server using localhost to communicate between the ui and the server. The server will most likely be implemented using TCP sockets.
