# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-swallow/gnome-swallow-1.1.ebuild,v 1.1 2003/06/08 20:23:27 liquidx Exp $

inherit gnome2

DESCRIPTION="A Applet for Gnome2 that 'Swallows' normal apps. Usefull for docks that are made for other DE's or WM's"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/swallow/${P}.tar.gz"
HOMEPAGE="http://www-unix.oit.umass.edu/~tetron/technology/swallow"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libgtop-2
	>=gnome-base/gnome-panel-2
	>=x11-libs/gtk+-2.2.1"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"

src_install() {
	gnome2_src_install
	rm -rf ${D}/usr/share/doc/gnome-swallow
}
