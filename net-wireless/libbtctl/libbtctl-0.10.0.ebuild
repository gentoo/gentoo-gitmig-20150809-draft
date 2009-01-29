# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.10.0.ebuild,v 1.4 2009/01/29 23:21:29 loki_val Exp $

inherit autotools gnome2 multilib mono

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
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

DOCS="README NEWS ChangeLog AUTHORS COPYING"

src_unpack() {
	gnome2_src_unpack

	# Fix multilib
	sed -e "s:\/lib\/:\/$(get_libdir)\/:" -i src/Makefile.am

	# Fix parallel make, bug #235991
	epatch "${FILESDIR}/${P}-parallel-make.patch"

	# Fix tests (needed with eautoreconf)
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_compile() {
	gnome2_src_configure --disable-mono

	sed -e 's/libext="a/& la/' -i libtool || die "sed failed"
	emake || die "compile failure"
}
