# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.9.0.ebuild,v 1.9 2009/11/21 15:12:19 armin76 Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit gnome2 multilib mono autotools

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2.25
	>=net-wireless/bluez-libs-2.25
	>=dev-libs/openobex-1.2
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="README NEWS ChangeLog AUTHORS"

src_unpack() {
	gnome2_src_unpack

	# Fix multilib
	sed -e "s:\/lib\/:\/$(get_libdir)\/:" -i src/Makefile.am

	# Fix tests (needed with eautoreconf)
	intltoolize --force
	eautoreconf
}

src_compile() {
	sed -i -e 's/libext="a/& la/' libtool

	gnome2_src_compile --disable-mono
}
