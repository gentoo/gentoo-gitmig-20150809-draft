# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/drwright/drwright-0.16.ebuild,v 1.2 2003/06/19 17:09:32 johnm Exp $

inherit gnome2 flag-o-matic gcc

DESCRIPTION="A GNOME2 Applet that forces you to take regular breaks to prevent RSI."
HOMEPAGE="http://drwright.codefactory.se/"
SRC_URI="http://drwright.codefactory.se/download/${P}.tar.gz"

[ "`gcc-version`" = "3.3" ] && append-flags -Wno-strict-aliasing

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.4
	>=x11-libs/pango-1.0.4
	>=dev-libs/glib-2.0.3
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libgnome-2.0.4
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libglade-2.0
	>=gnome-base/gnome-panel-2.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
