# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.0.5.ebuild,v 1.1 2002/09/06 05:01:04 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A text editor for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=x11-libs/pango-1.0.4
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2.0.1
	>=gnome-base/gnome-vfs-2.0.4
	>=gnome-base/eel-2.0.6
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/ORBit2-2.4.3
	>=gnome-base/libgnomeprintui-1.116.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

	
DOCS="AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS  README*  THANKS TODO"

