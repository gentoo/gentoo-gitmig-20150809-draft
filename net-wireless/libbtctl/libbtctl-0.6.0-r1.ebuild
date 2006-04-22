# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.6.0-r1.ebuild,v 1.1 2006/04/22 09:24:38 mrness Exp $

inherit gnome2 mono multilib eutils autotools

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mono doc"

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2.7
	>=net-wireless/bluez-libs-2.7
	>=dev-libs/openobex-1
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
	epatch "${FILESDIR}/${P}-libdir.patch"
	epatch "${FILESDIR}/${P}-aclocal_openobex.patch"

	eautoreconf
}

src_compile() {
	use sparc || G2CONF=$(use_enable mono)
	gnome2_src_configure
	sed -i -e 's/libext="a/& la/' libtool
	emake || die "make failed"
}
