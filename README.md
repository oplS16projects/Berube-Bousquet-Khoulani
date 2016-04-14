# Project Title: Checker Master

### Statement
In this project we will create an interactive checker game that can be played in a 1 or 2 player mode.  The 2 player mode will be a simple implementation of two human-controller clients talking to a server that verifies the validity of the moves taken.  The interesting portion will be in the 1 player mode where the human-controlled client is playing against an AI-controlled client.  This AI will have two settings of difficulty, one of which behaving like an intuitive human player, and the other will try to play a "perfect game", against which the best outcome is a draw.  We hope to learn about building a client-server interface, as well as how to build algorithms that will simulate certain player skill.

### Analysis
Much of this project will consist of recursive procedures.  Many of the algorithms designed to "solve" games have a recursive nature to them which is why the project is suitable for Racket.  We will make use of object orientation, particularly in the front-end portion of the program where we will have board and checker piece objects that will need handling.  The map/filter/reduce procedures may also prove useful in perhaps searching through a list of potential moves within the AI logic.  The server will be created using TCP sockets. These sockets essentially allow interfaces for both a client and a server; a client will create a connection, and a server socket will be opened that can accept the client's connection.

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
![ArchitectureDiagram.PNG](https://github.com/oplS16projects/Berube-Bousquet-Khoulani/blob/master/ArchitectureDiagram.PNG)

The server will open a TCP server-socket that searches for connections. Upon finding a connection, it can choose to accept it and thus establish a line of communication with the client. The client will create a connection using TCP, which can be accepted by the server.

We will create a series of clients that will communicate with the server.  One client can support 2 human players, the others support human players playing against 2 different AI's.  Each AI will have it's own seperate client.  The AI clients will communicate with the server to validate and log their moves.  

We felt it would be good practice to keep the human client from being able to communicate with the server, so the GUI will directly send the moves of the human player to be validated, and also communicate with the human client.  Both of the AI clients will be able to display their moves to the GUI via the server after their moves are validated.

## Schedule
### First Milestone (Fri Apr 15)
Progress as of 4/15:
Server has been set up so that in our testing a client could send information successfully to the server.  We are still working on the server validating the moves and might make the decision to have the game piece moves validated locally by the client, as it is faster and overall creates less complexity within the architecture's functionality.  The front-end can draw the board and add pieces to the board with hard coded locations.  Still need to add 'kinging' functionality to the pieces but at this point that is the only unaccomplished visual component.  Movement and piece jumping functionality is near finsihed and will likely be up within a few days.  The two AIs are still in their infancy, but we will be moving from pseudo code algorithms and starting to implement them in Racket by the end of next week hopefully.

Proposed Progress:
Client-server architecture has been set up.  Front-end will be at the very least functional and display the game board and will be able to draw pieces to hard coded spots.  Server work to verify these moves should be working for obvious cases.  The two player system will possibly completed based on how quickly the previous tasks are completed. The algorithms for both AI clients will be under development at this time.


### Second Milestone (Fri Apr 22)
Server will be properly verifying moves, with edge cases considered.  Front-end will be complete as far as visual interface.  Two player mode should be functional.  The server should also allow for a human-controlled client to play against an AI cliet so that testing of the AI algorithms can happen easier.  The AI clients should be at the very least in prototype stage where they can be played against by a human-controlled client with some demonstration of functionality.  The two AI's should be discernable at this stage already even if the smarter AI is not perfect yet.  Work should begin that will allow these two AI's to be played against eachother in some capacity to demonstrate their effectiveness in the final presentation.

### Final Presentation (last week of semester)
By this point the two AI's should now be functional enough to be played against fluidly by human players.  The server should also now support the functionality of playing the two AI's against eachother so that it can be shown that they superior AI wins every time.  This will be implemented in whichever way is the most effiencient based on the client-server implementation.  

## Group Responsibilities
### Samir Khoulani @skhoulani
Samir's job is to develop a basic heuristic that will result in an "easy" mode AI. In addition, Samir's tasks will be split between aiding the development of the advanced AI and server side communication programming, pending the completion of his simple AI. Testing of the simple AI will also be done following the fruition of the simple AI.

### Brendan Bousquet @brendanbousquet
Brendan will be responsible for contructing the smarter of the two AI.  Samir will likely assist with this once his AI is done toward the tail end of the project timeline. Brendan will be tasked with finding methods to test the functionality of the AI after it has been developed. Brendan will assist with some of the front end work while the research and initial implementation is being constructed for the AI.

### Sean Berube @sberube484
Sean is team lead. He will be working on the front end and will implement the 2-player mode. He will also work on implementing a server using localhost to communicate between the ui and the server. The server will most likely be implemented using TCP sockets.
