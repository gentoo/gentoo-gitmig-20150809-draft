# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.0.6.ebuild,v 1.6 2003/02/13 06:40:05 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha"

RDEPEND=">=dev-libs/popt-1.5
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2
	>=gnome-base/eel-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/ORBit2-2.4.3
	>=gnome-base/libgnomeprintui-1.115.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

	
DOCS="AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS  README*  THANKS TODO"

