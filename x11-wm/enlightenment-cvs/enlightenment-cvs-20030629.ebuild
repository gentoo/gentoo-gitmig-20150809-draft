# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-20030629.ebuild,v 1.13 2004/07/11 22:36:56 vapier Exp $

inherit enlightenment

DESCRIPTION="e17 meta ebuild ... emerge this to get all e17 components"
SRC_URI=""

RDEPEND="
	media-gfx/entice
	app-misc/examine
	media-libs/edje
	media-libs/epsilon
	app-sci/equate
	dev-db/edb
	x11-libs/ecore
	x11-libs/evas
	media-libs/imlib2
	media-libs/imlib2_loaders
	dev-libs/eet
	x11-libs/ewl
	media-libs/etox
	media-gfx/imlib2_tools
	sys-fs/efsd
	x11-misc/entrance
	app-misc/evidence
	media-gfx/elicit
	net-news/erss
	x11-libs/esmart
	dev-libs/embryo
	media-libs/epeg"

#	x11-misc/enotes
#	x11-libs/eprog
#	x11-misc/med
#	x11-wm/e

src_unpack() { :;}
src_compile() { :;}
src_install() { :;}
