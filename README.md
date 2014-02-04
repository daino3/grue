Sleepy Giant Code Challenge
----------------------

### Implementation Notes

Author: Dain Hall

This is a command line game. I've built the game so almost all the game logic exists in models/game.rb. The game is initialized with a map, which is a collection of room objects located at config/game_map.rb. A room is initialized with a name, outbound doors (hash) and an optional value to tell if the room contains a dais (true / false). A game initializes instances of a grue and a player. One unique thing in the game is that Jewels are randomly assigned to a grue with different attributes and point totals so that a player can have better / worse scores for the game. I've also included a difficulty method which seeds the map with a number of jewels depending on easy, medium, hard.

I tested private methods significantly because they were the meat and potatoes of the game and shortest path logic. I know you should probably test only public methods, but I wanted to isolate each 'unit' of logic indepedently.

### Assumptions:

Must give a 'circular' map - you must be able to get to any room (node) in the map via the outbound doors available. Room names must be unique. Room 'weights' are 1.

### To Run: 

Test Suite
'''
rspec tests/
'''

Application
'''
ruby play.rb
'''

### Project Details

Map:
--------------
### Vermillion Room
rooms: north -> nil, east -> Ochre, south -> Aquamarine, west -> nil

### Ochre Room
rooms: north -> nil, east -> Chartreuse, south -> nil, west -> Vermillion

### Chartreuse Room
rooms: north -> nil, east -> Ochre, south -> Emerald, west -> nil

### Lavender Room
rooms: north -> Chartreuse, east -> nil, south -> Burnt Sienna, west -> nil

### Emerald Room
rooms: north -> nil, east -> Lavender, south -> Aquamarin, west -> Cobalt 

### Aquamarine Room
rooms: north -> nil, east -> nil, south -> Violet, west -> Cobalt  

### Cobalt Room
rooms: north -> Vermillion, east -> nil, south -> Burnt Sienna, west -> nil 

### Violet Room
rooms: north -> nil, east -> Burnt Sienna, south -> Chartreuse, west -> nil  

### Burnt Sienna Room
rooms: north -> Emerald, east -> Lavender, south -> nil, west -> nil

Directions:
-------------------

1) The world is a bunch of rooms connected by one­way corridors.  Being one­way, corridors
are either "in­bound" or "out­bound", depending on the perspective of which room you're in.

2) Each room has up to 4 doors, in the 4 cardinal directions.

3) Some doors only open one way, other doors open both ways, but being imbued with ornery
magic, no door will open onto the same corridor from both directions. I.e., if you go from Room Ato Room B via a corridor, you should never be able to turn around and go back into Room A via
that same door.

4) From any given room, you cannot tell which doors are connected to "in­bound" corridors. You
can tell which doors are "out­bound", by trying them in turn and seeing which of them open. Note:No rooms are dead­ends (featuring only "in­bound" routes).

5) The game is turn­based.  During each turn, you must try to go north, south, east, or west, or pick up a gem (see below).  If a given direction does not work, you can try again. A failed move attempt / retry does *not* consume a turn If the door leads to a corridor, opening the door and traveling to the other room together consume a single turn.

6) Every 4 turns, you must rest for 1 turn. (I.e., every 5th turn is a resting turn).

7) There is a Grue in the dungeon with you, who spawns upon your arrival, far away from your start point.  Any time you rest, you stop making noise, which frees the Grue to move, one corridor per turn.  The Grue always knows the shortest path to reach your resting spot.  If the
Grue attacks you, you're dead.  If you die, you lose your gems and respawn randomly.

8) If you actively enter a room containing the Grue, he will drop a gem and flee randomly one
room away.  (To attack you he must be the one entering the room.)  Thus, when you see a gem,
you can surmise that a Grue is very nearby.  You will automatically pick up the dropped gem
(and this does not consume another turn).

9) Your goal is to collect 5 gems, then make your way to a target room (e.g., the Cobalt Room),
at which point you are transported home.  (There should be some clear indication of which room
is the teleport room, perhaps it has a glowing dais in the center).

### Further Implementation Notes:

* We prefer that you use Ruby or a similar dynamic language for the implementation. (e.g.,
Python, JavaScript within Node.js, etc)

* Please use git to track your progress. Please make regular small commits so we can see your
thought process unfold.

* Please DO NOT upload to Github, however. We’d like to avoid having to write new exercises
every week :)

* Don't worry about graphics.  Zork­style text­based is fine. However if you want to make a
graphical version, go to town!

* Please express the map and the teleport room via a configuration file (make the map editable,
do not hardcode it).

* If you want to make the game a bit easier, you can scatter a few gems around randomly when
you initialize the map.

* Also, if you want to make the game a bit easier, you can warn the player by making the Grue
detectable. E.g., if the Grue is 1 room away, the system can announce “You can smell the Grue!
It is nearby!”

* Please implement the sample map.