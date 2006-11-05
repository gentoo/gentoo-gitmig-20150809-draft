# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.8.1.ebuild,v 1.3 2006/11/05 21:30:38 peper Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit gnome2 multilib mono autotools

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mono doc"

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2.25
	>=net-wireless/bluez-libs-2.25
	>=dev-libs/openobex-1.2
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.0
	!sparc? (
		mono? (
			>=dev-lang/mono-0.96
			=dev-dotnet/gtk-sharp-1.0*
		)
	)"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="README NEWS ChangeLog AUTHORS COPYING"
USE_DESTDIR="yes"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix multilib
	sed -e "s:\/lib\/:\/$(get_libdir)\/:" -i src/Makefile.am
	eautoreconf
}

src_compile() {
	use sparc || G2CONF=$(use_enable mono)
	gnome2_src_configure
	sed -i -e 's/libext="a/& la/' libtool
	emake || die "make failed"
}
