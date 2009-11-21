# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.11.0.ebuild,v 1.4 2009/11/21 15:13:09 armin76 Exp $

inherit distutils gnome2 eutils multilib autotools

DESCRIPTION="Gnome2 Bluetooth integration suite"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2.10
	>=gnome-base/librsvg-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	>=dev-libs/openobex-1.2
	>=net-wireless/bluez-libs-2.25
	>=net-wireless/libbtctl-0.9
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-2.6"

DEPEND="${RDEPEND}
	>=dev-util/gob-2
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
#MAKEOPTS="${MAKEOPTS} -j1"
PYTHON_MODNAME="gnomebt"

src_unpack() {
	gnome2_src_unpack

	sed -i -e 's:${libdir:/${platlibdir:' acinclude.m4 || die "sed failed"
	intltoolize --force
	eautoreconf

	# Python <=2.4 and Automake fails to support multilib wrt #187826
	sed -e "s:$PYTHON -c \"from:true \"from:g" \
		-e "s:lib/python:$(get_libdir)/python:g" \
		-i configure
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
