# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/stickynotes_applet/stickynotes_applet-1.0.11.ebuild,v 1.1 2003/06/01 23:59:48 jayskwak Exp $

inherit gnome2

DESCRIPTION="simple applet to create, view, and manage sticky notes for Gnome2"
HOMEPAGE="http://loban.caltech.edu/stickynotes/"
SRC_URI="http://loban.caltech.edu/stickynotes/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2
	=gnome-base/libgnomeprintui-2.2*
	>=gnome-base/libgnomecanvas-2
	>=media-libs/gdk-pixbuf-0.2"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

DOCS="AUTHORS COPYING ChangLog INSTALL NEWS README THANKS TODO"
