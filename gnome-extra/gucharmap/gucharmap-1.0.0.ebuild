# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-1.0.0.ebuild,v 1.1 2003/09/09 22:25:45 foser Exp $

inherit gnome2 eutils

DESCRIPTION="Unicode charachter map viewer"
HOMEPAGE="http://gucharmap.sourceforge.net"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="gnome cjk"

RDEPEND=">=x11-libs/gtk+-2.2
	dev-libs/popt
	gnome? ( >=gnome-base/libgnome-2.2
		 >=gnome-base/libgnomeui-2.2 )
	!<gnome-extra/gnome-utils-2.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} $(use_enable gnome) $(use_enable cjk unihan) --disable-gtk-immodules"

pkg_postinst() {
	einfo "Registering GKT+ input modules..."
	${ROOT}/usr/bin/gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
	einfo "Registering GKT+ input modules..."
	${ROOT}/usr/bin/gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}

