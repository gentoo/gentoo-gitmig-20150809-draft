# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.1.1.ebuild,v 1.1 2002/10/27 14:01:01 foser Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND="=x11-libs/pango-1.1*
	=x11-libs/gtk+-2.1*
	>=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2.0.1
	>=gnome-base/gnome-vfs-2.0.4
	=gnome-base/eel-2.1*
	=gnome-base/libgnomeui-2.1*
	>=gnome-base/libbonobo-2.0
	>=gnome-base/ORBit2-2*
	>=gnome-base/libgnomeprintui-1.116.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

	
DOCS="AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS  README*  THANKS TODO"

