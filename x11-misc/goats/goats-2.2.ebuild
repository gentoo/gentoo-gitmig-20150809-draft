# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/goats/goats-2.2.ebuild,v 1.1 2003/05/09 12:50:26 foser Exp $

inherit gnome2

DESCRIPTION="Goats is a yellow post-it note applet for the GNOME desktop"
SRC_URI="http://www.menudo.freeserve.co.uk/${P}.tar.gz"
HOMEPAGE="http://www.menudo.freeserve.co.uk/goats.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/gconf-1.2.1
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2
	=gnome-base/libgnomeprintui-2.2*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

DOCS="ABOUT-NLS AUTHORS BUGS ChangeLog NEWS COPYING README TODO"
