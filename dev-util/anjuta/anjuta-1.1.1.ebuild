# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.1.1.ebuild,v 1.3 2003/06/07 17:45:27 foser Exp $

# development version
inherit gnome2 debug

DESCRIPTION="A versatile IDE for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.8
	>=gnome-base/ORBit2-2.4
	>=gnome-base/libglade-2
        >=gnome-base/libgnome-2.0.2
        >=gnome-base/libgnomeui-2.0.2
	>=gnome-base/libgnomeprint-2.0.1
	>=gnome-base/libgnomeprintui-2.0.1
        >=gnome-base/gnome-vfs-2.0.2
        >=gnome-base/libbonobo-2
        >=gnome-base/libbonobo-2.0.1
	>=x11-libs/libzvt-2
	>=x11-libs/vte-0.9
	>=dev-libs/libxml2-2.4.23
	>=x11-libs/pango-1.1.1
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING ChangeLog FUTURE NEWS README THANKS TODO"
