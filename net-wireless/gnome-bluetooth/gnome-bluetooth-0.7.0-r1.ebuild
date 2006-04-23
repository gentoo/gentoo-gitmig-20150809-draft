# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.7.0-r1.ebuild,v 1.2 2006/04/23 17:15:08 mrness Exp $

inherit distutils gnome2 eutils multilib autotools

DESCRIPTION="Gnome2 Bluetooth integration suite."
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
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
	>=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.25
	>=net-wireless/libbtctl-0.6.0-r1
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-2.6"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
MAKEOPTS="${MAKEOPTS} -j1"
PYTHON_MODNAME="gnomebt"
USE_DESTDIR=1

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:${libdir:/${platlibdir:' acinclude.m4
	sed -i -e 's:blueradio-48.png:blueradio.png:' python/manager.py
	epatch "${FILESDIR}/${P}-aclocal_openobex.patch"
	eautoreconf
}

src_compile() {
	platlibdir=$(get_libdir) gnome2_src_compile
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_pkg_postinst
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_pkg_postrm
}
