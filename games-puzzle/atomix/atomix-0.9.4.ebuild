# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/atomix/atomix-0.9.4.ebuild,v 1.2 2004/01/02 18:36:28 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="a little mind game for GNOME2"
SRC_URI="http://triq.net/~pearl/download/${P}.tar.gz"
HOMEPAGE="http://triq.net/~pearl/atomix.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=x11-libs/pango-1.0.3
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.4
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=dev-libs/libxml2-2.4.23"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

DOCS="AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS README* THANKS TODO"
