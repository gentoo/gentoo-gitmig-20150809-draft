Gentoo Linux Enhancement Proposals
==================================

This directory contains the official (CVS-controlled) 
texts of current and past Gentoo Linux Enhancement 
Proposals (GLEPs), along with some necessary scripts
and configuration files to facilitate converting the
GLEPs from (really quite readable) raw ASCII text
to html or xml.

Requirements
============

GLEPs are written in ReStructuredText [#ReST]_, which
is text with some minimal markup so that it is still
quite readable in source form, yet it can be readily
converted to html or xml for viewing with a browser.

Converting ReST to html or xml requires the "docutils" python package
[#docutils]_::
	
	# emerge docutils

The Gentoo Linux docutils package includes the *glep.py* program 
which transforms a GLEP in text form to the equivalent html version::

	# glep.py glep-0001.txt glep-0001.html

(Incidentally, *glep.py* contains special code to verify that
the GLEP header is reasonable.  This README lacks that header,
so to convert this file to html using docutils you need to 
use the more generic transformation program::

	# html.py --stylesheet-path=tools/glep.css README.txt README.html

to convert README.txt to README.html.)

Files
=====

========================	======================================
File 						Purpose
========================	======================================
README.txt					This file (duh!)
docutils.conf				Configuration file for GLEP conversion 
								from txt to html
glep-xxxx.txt				GLEPs in text (ReST) form
tools/glep.css				GLEP html stylesheet
tools/glep-html-template	GLEP boilerplate template
========================	======================================


References
==========

.. [#ReST] ReStructuredText,
   http://docutils.sourceforge.net/docs/rst/quickstart.html

.. [#docutils] http://docutils.sourceforge.net/
