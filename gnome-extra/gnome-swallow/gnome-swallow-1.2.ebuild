# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-swallow/gnome-swallow-1.2.ebuild,v 1.6 2006/08/11 20:04:18 dang Exp $

inherit gnome2

DESCRIPTION="An applet for Gnome2 that 'swallows' normal apps. Useful for docks that are made for other DEs or WMs"
HOMEPAGE="http://interreality.org/~tetron/technology/swallow/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

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
