WHAT THIS GAME IS

	WIP game project made for crux round one inductions 

	the goal of this game was to make a simple wave defence game where zombies come from random sides of the screen and follow the player's movements trying to attack the player

	The game is being made using lua and love2d as it was relatively easy to pick up, in the future i want to be able to make games out of C++/C# and more fully featured engines

	in its current state, 8 direction movement, the player sprite, basic config and background is completed however i might change the sprite later on for aesthetic purposes 

	the attempt file is a temp file where i would try to make certain changes that i was affraid would break the game

	the anim8 folder contains the files of a library that someone else made, this is to simplify the process of changing the sprite in the future but for now it is unused as it is not needed with such a simple sprite

	the zombie file is an object that contains all the data for the zombies, it has the basic data of what the zombie looks like and default spawn position which i will eventually randomise, it will also have all the functions related to
	how the zombie moves and attacks the player

	the player object is present in the main.lua file and is called knight (due to the sprite being a knight)
	
HOW TO RUN IT
    install love2d (on fedora it's "sudo dnf install love")
    Clone the repository
    cd into it
    execute the command "love ."
        a 1280x720 window should open with a blue background and a knight should be able to move using WASD
        the top right has an FPS counter
        the top left has the position of the top left of the sprite (which is shown by a drawn circle)

WHAT IS LEFT TO DO
    menu -- main menu which has buttons that allow you to change game state and maybe config options 
    enemies -- add sprites and logic that follows the player's position around, give them some health and a way to reduce it
    attack -- a way to attack the enemies 
    difficulty -- some sort of progression and an ending, a way to lose
    music -- some BGM and some SFX
    

    
    
    
