# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.4.1.ebuild,v 1.4 2004/07/20 23:10:18 liquidx Exp $

inherit gnome2 mono

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"
SRC_URI="http://downloads.usefulinc.com/libbtctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="mono"

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2.7
	>=net-wireless/bluez-libs-2.7
	>=dev-libs/openobex-1
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.0
	!sparc? ( mono? ( >=dev-dotnet/mono-0.96 ) )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="README NEWS ChangeLog AUTHORS COPYING"
USE_DESTDIR="yes"

src_compile() {
	use sparc || G2CONF="`use_enable mono`"
	gnome2_src_configure
	sed -i -e "s/libext=\"a/& la/" libtool
	emake || die "make failed"
}
