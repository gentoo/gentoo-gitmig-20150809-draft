# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-20030220.ebuild,v 1.1 2003/02/27 03:31:46 vapier Exp $

DESCRIPTION="e17 meta ebuild ... emerge this to get all e17 components"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="media-gfx/etcher
	media-gfx/ebony
	media-gfx/entice
	x11-misc/med
	x11-misc/ebindings
	dev-db/edb
	media-libs/estyle
	x11-libs/ecore
	media-libs/ebits
	dev-libs/ewd
	x11-libs/evas
	media-libs/imlib2
	media-libs/imlib2_loaders
	dev-libs/eet
	x11-libs/eprog
	x11-libs/ewl
	media-libs/etox
	media-libs/ebg
	dev-lang/esmall
	media-gfx/imlib2_tools
	sys-apps/efsd
	x11-wm/e"

# not done yet ;)
#x11-misc/elogin
#x11-misc/entrance
#x11-misc/enotes
#app-misc/evidence
