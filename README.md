# ODDS AND ENDS: README #

## TABLE OF CONTENTS ##

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[1.0.0] Introduction
[2.0.0] Getting Started
[3.0.0] Working With This Project
[4.0.0] Troubleshooting & Other Tips
[5.0.0] Appendix
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- - -
## [1.0.0] Introduction ##

IN THIS CHAPTER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[1.1.0] Abstract
[1.2.0] Requirements
[1.3.0] Credits
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### [1.1.0] Abstract ###

This is a game started in GDD1 and continued in GDD2.

### [1.2.0] Requirements ###

* Flash CC

### [1.3.0] Credits ###

* Product Owner, Project Lead, Level Design: Edward Finer
* Programming, Sound: Theodore "Ted" Greene
* Programming: Julien Kilian
* Art, Level Design: Danish Bukhari
* Art: Sean Mooney
* XML Handling Code: *special thanks to* Prof. Anthony Jefferson 

- - -
## [2.0.0] Getting Started ##

IN THIS CHAPTER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[2.1.0] Folder Structure
[2.2.0] Flash Develop
[2.3.0] Git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### [2.1.0] Folder Structure ###

* bin: Contains our level data XML file, and the compiled SWF (when created).
  
* src: Contains the source code files and the .fla project file.
	* com: Package folder for the .as code files.

* Raw Assets: Contains original versions of the game's visual and audio effects, 
	as well as a copy of the game's story.
  * Art: Contains image files of the game's art assets.
  * Fonts: Contains the font faces used in the project.
  * Sound: Contains the various sound effects used in the game.

### [2.2.0] FlashDevelop ###

FlashDevelop is a free IDE that operates a lot like Visual Studio. 
If you can use Visual Studio 2010 or later, then you can jump right into FlashDevelop.

As for workflow, all code editing should be done in FlashDevelop; when you're ready to test, fire up
the FLA project file in Flash CC and hit "Test Project" (the small blue arrow; keyboard shortcut is
usually CTRL + Enter on Windows).

#### IMPORTANT! ####

If you want to use the much, **MUCH** better FlashDevelop debugger, 
you're going to need a special version of Flash Player, which is located here:

http://download.macromedia.com/pub/flashplayer/updaters/11/flashplayer_11_7_sa_debug.exe

Once you have that, place it in:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 C:\Program Files (x86)\FlashDevelop\Tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After that, go to your program settings in FlashDevelop to change the path of the external Flash Player:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tools -> Program Settings -> 
Under plugins, choose FlashViewer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the External Player Path to:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C:\Program Files (x86)\FlashDevelop\Tools\flashplayer_11_7_sa_debug.exe
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### [2.3.0] Git ###

Git will ignore automatically-generated files (such as the .SWF) when committing.
There's no real reason for the latest SWF revision to be committed; a new one
can be built from the FLA file as needed.
- - -
## [3.0.0] Working With This Project ##

IN THIS CHAPTER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Information still to be added.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- - -
## [4.0.0] Troubleshooting & Other Tips ##

IN THIS CHAPTER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Information still to be added.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- - -
## [5.0.0] Appendix ##

IN THIS CHAPTER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Information still to be added.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
