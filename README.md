# Project Title: Checker Master

### Statement
In this project we will create an interactive checker game that can be played in a 1 or 2 player mode.  The 2 player mode will be a simple implementation of two human-controller clients talking to a server that verifies the validity of the moves taken.  The interesting portion will be in the 1 player mode where the human-controlled client is playing against an AI-controlled client.  This AI will have two settings of difficulty, one of which behaving like an intuitive human player, and the other will try to play a "perfect game", against which the best outcome is a draw.  We hope to learn about building a client-server interface, as well as how to build algorithms that will simulate certain player skill.

### Analysis
Much of this project will consist of recursive procedures.  Many of the algorithms designed to "solve" games have a recursive nature to them which is why the project is suitable for Racket.  We will make use of object orientation, particularly in the front-end portion of the program where we will have board and checker piece objects that will need handling.  The map/filter/reduce procedures may also prove useful in perhaps searching through a list of potential moves within the AI logic.  (Insert info here regarding client-server interface)

Fred's Text(
Explain what approaches from class you will bring to bear on the project. Be explicit: e.g., will you use recursion? How? Will you use map/filter/reduce? How? Will you use data abstraction? Will you use object-orientation? Will you use functional approaches to processing your data? Will you use state-modification approaches? A combination?

The idea here is to identify what ideas from the class you will use in carrying out your project. 
)

### Data set or other source materials
We will be using at the very least the visuals (game board and piece image drawing) and simple structure (a class involving the drawing and structure of the board) of the in-language Racket simple checkers game (with no AI player) to help implement the front end of the program.  This is in the games/gl-board-game library.

In addition to this we will be using whatever resources that can be found regarding the solved checker algorithm from the University of Alberta who originally solved it.  Their method uses databases consisting of opening moves and strategies from checker masters rather than just a logical algorithm so if any of those databases are public that would be the best possible implementation.  However many of their resources are unavailable (lots of 404 errors on their pages) so there may be a need for other research sources to construct a "perfect" AI player.

Fred's Text(
How will you convert that data into a form usable for your project?  

Do your homework here: if you are pulling data from somewhere, actually go download it and look at it. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materails, explain what they are. Basically: anything you plan to use that isn't code.
)

### Deliverable and Demonstration
Ideally we will have an interactive program that will be able to: have two human-controlled clients play eachother via the server from different machines, have a human-controlled client play an AI-controlled client that behaves similarly to a human player, and have a human-controlled client play an AI-controlled client that will play such that the best the human player can do is tie the AI player.

There is the possibility that this last objective will not be achievable with the resources available, however it is most likely that an AI that plays a nearly perfect game is certainly achievable do to the non-complicated nature of the game of checkers.

We will at the time of the demonstration be able to show the program working in all of these three capacities to the class.  In order to speed up the demonstration of the perfect game we may have to show a partially completed game finishing with a tie or demonstrate in some way how the AI plays in a strategically perfect way.

Fred's Text(
What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.
)

### Evaluation of Results
We can demonstrate our success by showing that a game can be completed successfully (meaning all moves follow the rules of checkers) between two humans, and between a human and both of the AI's repectively.  However we would be left with the issue of how good the AI's are comparatively.  We can show the "perfect" AI is better than the "human" AI by creating an interface in which the two AI clients are connected to a server to play a game against one another.  In this situation the "perfect" AI will beat the "human" AI every time.  That way the AI's can be considered objectively successful in the manner in which they are constructed.

Fred's Text(
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.
)

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Fri Apr 15)
What exactly will be turned in on this day? 

### Second Milestone (Fri Apr 22)
What exactly will be turned in on this day? 

### Final Presentation (last week of semester)
What additionally will be done in the last chunk of time?

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Susan Scheme @susanscheme
will write the....

### Leonard Lambda @lennylambda
will work on...

### Frank Functions @frankiefunk 
Frank is team lead. Additionally, Frank will work on...  
