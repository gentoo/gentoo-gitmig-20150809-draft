# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.11.1.ebuild,v 1.5 2009/11/21 15:12:19 armin76 Exp $

inherit gnome2 multilib mono

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=net-wireless/bluez-4
	>=dev-libs/openobex-1.2
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="README NEWS ChangeLog AUTHORS"

src_unpack() {
	gnome2_src_unpack

	# Fix multilib
	sed -e "s:/lib/python:/$(get_libdir)/python:" \
		-i src/Makefile.am src/Makefile.in || die "sed 1 failed"
}

src_compile() {
	gnome2_src_configure --disable-mono

	sed -e 's/libext="a/& la/' -i libtool || die "sed 2 failed"
	emake || die "compile failure"
}
