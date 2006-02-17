# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.6.0.ebuild,v 1.6 2006/02/17 19:44:32 hansmi Exp $

inherit distutils gnome2 eutils

DESCRIPTION="Gnome2 Bluetooth integration suite."
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2.1.3
	>=x11-libs/gtk+-2
	>=gnome-base/librsvg-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	>=dev-util/gob-2
	=dev-libs/openobex-1.0*
	>=net-wireless/bluez-libs-2.7
	=net-wireless/libbtctl-0.5*
	>=dev-python/pygtk-2.0
	>=dev-python/gnome-python-2"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
MAKEOPTS="${MAKEOPTS} -j1"
PYTHON_MODNAME="gnomebt"
USE_DESTDIR=1

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5.1-obex_xfer_rate.patch
	epatch ${FILESDIR}/${P}-libdir.patch
	export WANT_AUTOMAKE="1.5"
	libtoolize --force --copy || die
	aclocal || die
	automake -a || die
	autoconf || die
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_pkg_postinst
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_pkg_postrm
}
