# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-swallow/gnome-swallow-1.1.ebuild,v 1.4 2003/08/07 03:42:48 vapier Exp $

inherit gnome2

DESCRIPTION="A Applet for Gnome2 that 'Swallows' normal apps. Usefull for docks that are made for other DE's or WM's"
HOMEPAGE="http://www-unix.oit.umass.edu/~tetron/technology/swallow"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/swallow/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libgtop-2
	>=gnome-base/gnome-panel-2
	>=x11-libs/gtk+-2.2.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"

src_install() {
	gnome2_src_install
	rm -rf ${D}/usr/share/doc/gnome-swallow
}
