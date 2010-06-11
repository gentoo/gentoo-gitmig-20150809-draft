# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.12.0.ebuild,v 1.4 2010/06/11 11:54:13 pacho Exp $

inherit distutils gnome2

DESCRIPTION="Gnome2 Bluetooth integration suite"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2.10
	>=gnome-base/librsvg-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-2.3.3
	>=gnome-base/orbit-2
	>=net-wireless/libbtctl-0.9
	>=dev-python/pygtk-2.6"

DEPEND="${RDEPEND}
	>=dev-util/gob-2
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"

PYTHON_MODNAME="gnomebt"

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_pkg_postinst
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_pkg_postrm
}
