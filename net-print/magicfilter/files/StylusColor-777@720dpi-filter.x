%include <filters.h>
#
# Magic filter setup file for the EPSON Stylus Color 777 printer
# operating at 720 dpi, originally based on StylusColor-800@360dpi-filter.
# 
# There is no warranty for anything whatsoever!
#
# This file is covered by the GNU General Public License as published
# by the Free Software Foundation; either version 2, or (at your
# option) any later version.
#
# Copyright © 2001 Aron Griffis <agriffis@gentoo.org>
#
# This file has been automatically adapted to your system.
%ifndef HAVE_GHOSTSCRIPT
# However, since you did not have Ghostscript installed, most entries
# are going to be rejects.
%endif
%define DPI 720		/* printer resolution */
%define IS_COLOR 1	/* color capability */

# All documents sent to the printer should be prefixed by the magic
# command and the reset code.  The 'magic command' takes the printer
# out of the Epson packet mode communication protocol (whatever that
# is) and enables normal data transfer.  The 'reset code' discards any
# output, ejects the existing page, and returns all settings to their
# default.
0	\000\000\000\033\001@EJL\ 1284.4\n@EJL\ \ \ \ \ \n\033@	cat

# Native printer control codes start with <ESC>, but if this wasn't
# recognized by the magic above, then the reset code should be
# prefixed.  Then we pass the document to the printer, cross our
# fingers and hope for the best.
#
# Note that we add a ff/reset on the end just for good measure...
0	\033	cat \000\000\000\033\001@EJL\ 1284.4\n@EJL\ \ \ \ \ \n\033@ \014\033@

%ifdef HAVE_GHOSTSCRIPT
%define HANDLE_PS	pipe	PATH_GHOSTSCRIPT -sDEVICE=stp -sModel=escp2-777 -sQuality="720 D""PI Softweave" -r720x720 -sDither="Adaptive Hybrid" -sInkType="Four Color Standard" -sMediaType="Plain Paper" -dImageType=1 -dNOPAUSE -dSAFER -q -sOutputFile=- - -c quit
%define HANDLE_PDF	fpipe	PATH_GHOSTSCRIPT -sDEVICE=stp -sModel=escp2-777 -sQuality="720 D""PI Softweave" -r720x720 -sDither="Adaptive Hybrid" -sInkType="Four Color Standard" -sMediaType="Plain Paper" -dImageType=1 -dNOPAUSE -dSAFER -q -sOutputFile=- $FILE -c quit
%endif
%define HANDLE_TEXT	/usr/share/magicfilter/stc777-text-helper

%ifdef HAVE_GHOSTSCRIPT
# For PostScript, use ghostscript with the gimp-print driver.  This is
# done as a pipe (instead of a filter, which would go directly to the
# printer) so that magicfilter can then decide whether or not a reset
# sequence should be prefixed to the output.
#
# See `Devices.htm' for a description of the GhostScript options. They are
# needed and are not documented in the GhostScript manual page since they are
# specific to the GhostScript device drivers.
%endif

%include <stdconv.mh>

# Default entry for normal (text) files.  This must be the last entry!
# =====================================================================
default HANDLE_TEXT
