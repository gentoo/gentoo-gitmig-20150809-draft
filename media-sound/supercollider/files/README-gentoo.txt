Testing SuperCollider Installation
----------------------------------

To make sure that the SuperCollider install is working properly:

 1) Ensure that Jack is running ("jackd -d alsa")
 2) Ensure that you're going to run these commands from a directory
    which contains the subdirectories sounds/ and synthdefs/
    (these directories can be initially empty)
 3) execute the following command:
      sclang @DOCBASE@/examples/onetwoonetwo.sc -

If all goes well, you'll get some scrolling output, and then you'll
hear a looping synth line.  If the sclang command just sits there after
complaining about some error, hit Ctrl-C to get out of the loop and
start reading through the various online docs or filing some bugs
to see if you can find what the problem is.

Emacs Support
-------------

The online documentation seems to be largely of the opinion that emacs
is the preferred interface for working with SuperCollider.  Since emacs
support is optional, you must have emacs in your USE flags if you want
to have emacs support compiled in.  To start up emacs in SCLang mode,
first add the following line to ~/.emacs:

	(require 'sclang)

And then run emacs as "emacs -sclang"

Configuration Files
-------------------

The main configuration file which loads the various libraries that
SuperCollider will use is located at /etc/supercollider/sclang.cfg
Values from this file can be overridden in ~/.sclang.cfg, or in
.sclang.cfg in the directory sclang is being run from.

Another configuration file which controls how SuperCollider
connects to Jack, among other miscellaneous functions, can be created
as ~/.sclang.sc  -  Creating this file shouldn't be necessary, but an
example is provided in @DOCBASE@/examples

Running in General
------------------

Once again, it bears repeating that Jack *must* be running, and the
program *must* be started from inside a directory which contains
sounds/ and synthdefs/.  (Technically, you could alternatively start
sclang with the "-d" option to select a different directory
containing those two subdirs.)

Other Documentation in This Directory
-------------------------------------
Included in the SuperCollider source tree are quite a few .rtf files
which seem to serve as documentation.  I'm not sure exactly how useful
these files are, because they may pertain more to the GUI aspects of
the older Mac versions of SuperCollider, but they're included in
the install tree anyway.

More Information
----------------

The Official SuperCollider Homepage
http://www.audiosynth.com/
This page may not actually provide too much help, because it's still
geared for the Mac versions of SuperCollider, not the Linux versions.
Still, it's the official page.

SuperCollider Wiki
http://swiki.hfbk-hamburg.de:8888/MusicTechnology/6
This is a very informative Wiki devoted to running and developing
SuperCollider.  Pages of particular interest here:

  * http://swiki.hfbk-hamburg.de:8888/MusicTechnology/478
    General SuperCollider-on-Linux information
  
  * http://swiki.hfbk-hamburg.de:8888/MusicTechnology/579
    SuperCollider and Emacs

SuperCollider Mailing List
http://www.create.ucsb.edu/mailman/listinfo/sc-users
Probably the best place to go for problems that aren't specifically
Gentoo-related
