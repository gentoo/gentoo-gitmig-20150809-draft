# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-20030629.ebuild,v 1.6 2004/01/14 19:49:15 vapier Exp $

inherit enlightenment

DESCRIPTION="e17 meta ebuild ... emerge this to get all e17 components"
SRC_URI=""

RDEPEND="media-gfx/etcher
	media-gfx/ebony
	media-gfx/entice
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
	x11-libs/ewl
	media-libs/etox
	media-libs/ebg
	dev-lang/esmall
	media-gfx/imlib2_tools
	sys-fs/efsd
	x11-wm/e
	x11-misc/entrance
	app-misc/evidence
	media-gfx/elicit"

#x11-misc/enotes
#	x11-libs/eprog
#	x11-misc/med

src_unpack() { :;}
src_compile() { :;}
src_install() { :;}
