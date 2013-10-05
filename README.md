==============================================================
	                                 Odds and Ends
==============================================================
[Chapter.Section.Subsection] Title: Content is shown here in sentances. The
bracket system makes for very easy searching. Try it out!
		* Content can also be shown here in bullet points.
		* Like this.
			* Also, like this.
		1.) Content can also be shown in a numbered list.
		2.) In this format as you can see.
		3.) It can also have a numbered list.
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[1.0.0] Introduction
[2.0.0] Getting Started
[3.0.0] Working With This Project
[4.0.0] Troubleshooting and Tips
[5.0.0] Appendix

/*==[1.0.0] Introduction==============================================

		[1.1.0] Abstract
		[1.2.0] Requirments
		[1.3.0] Credits

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[1.1.0] Abstract:
This is a game started in GDD1 and continued in GDD2

[1.2.0] Requirments:
*Flash CC

[1.3.0] Credits:
SCRUM Master: Theodore "Ted" Greene
Art/Level Designer: Danish Bukhari
Art/Sound: Sean Mooney
==============================================================*/

/*==[2.0.0] Getting Started==============================================

		[2.1.0] Folder Structure
		[2.2.0] Flash Develop
		[2.3.0] Git

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[2.1.0] Folder Structure:
bin: Where the compiled .swf is built to
src: Where the source files are for code and the .Flash
	com: Where th code is
	data: Where things like .xml will be
	sound: Where special sound assets go
	?:
Raw Assets: Since the asset you have in game might need to be cut up, resized,
or messed with, here is where we have all the originals stored. Never use this in the .fla

[2.2.0] Flash Develop
Flash Develop4 is an IDE just like visual studio. If you can use VS201X then you can jump right into this.
The workflow is that your coding editing is in FD4 and when you want to test your movie open up the fla and hit Test Project
(the small blue arrow).

Important! If you want to actually use FD4's much much better debugger you need a special version of FlashPlayer located here:
http://download.macromedia.com/pub/flashplayer/updaters/11/flashplayer_11_7_sa_debug.exe

Once you have that, place it in C:\Program Files (x86)\FlashDevelop\Tools and go to your program settings to change the path of the extenal FlashPlayer

To do this go to Tools->Proram Settings-> Under plugins choose FlashViewer->Change External Player Path to C:\Program Files (x86)\FlashDevelop\Tools\flashplayer_11_7_sa_debug.exe

[2.3.0] Git
Git will ignore commiting the autogenerated files such as .swf because no body needs the latest revision of that if they can just build it themselfs