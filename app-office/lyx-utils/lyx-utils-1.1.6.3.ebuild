# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx-utils/lyx-utils-1.1.6.3.ebuild,v 1.2 2001/08/18 14:04:35 danarmak Exp $

# This ebuild does nothing, it depends on lyx-base and on all known
# packages lyx can make use of. See the lyx-base ebuild for more info.
# Note that these packages ( the ones this ebuild depends on) can be
# installed in any order, both before and after the lyx installation;
# when lyx runs it automatically uses whatever it finds.

DESCRIPTION="All the utils/packages LyX (lyx-base.ebuild) can make use of."

HOMEPAGE="http://www.lyx.org/"

DEPEND="~app-office/lyx-base-1.1.6.3
	app-text/ghostscript
	app-text/xpdf
	app-text/ispell
	app-text/gv
	app-text/latex2html
	media-gfx/imagemagick
	virtual/lpr
	app-text/rcs
	dev-util/cvs
	app-text/sgmltools-lite
	app-text/noweb"
#	app-text/chktex"
	
# Missing from this list:
# sgmltools - www.sgmltools.org is unreachable so I couldn't make
# an ebuild for it. Lyx uses sgmltools for DocBook conversion.
