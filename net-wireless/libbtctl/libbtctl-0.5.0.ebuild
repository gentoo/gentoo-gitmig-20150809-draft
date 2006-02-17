# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.5.0.ebuild,v 1.4 2006/02/17 19:43:17 hansmi Exp $

inherit gnome2 mono multilib eutils

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="mono doc"

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2.7
	>=net-wireless/bluez-libs-2.7
	=dev-libs/openobex-1.0*
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
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.4.1-libdir.patch
}

src_compile() {
	use sparc || G2CONF="`use_enable mono`"
	gnome2_src_configure
	sed -i -e "s/libext=\"a/& la/" libtool
	emake || die "make failed"
}
