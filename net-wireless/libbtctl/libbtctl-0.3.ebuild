# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.3.ebuild,v 1.10 2004/06/27 19:07:32 liquidx Exp $

inherit gnome2

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"
SRC_URI="http://usefulinc.com/software/gnome-bluetooth/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2
	|| ( >=net-wireless/bluez-libs-2.7 ( <net-wireless/bluez-libs-2.7 net-wireless/bluez-sdp ) )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="README NEWS ChangeLog AUTHORS COPYING"

src_unpack() {
	unpack ${A}
	sed -i -e 's/-lsdp/-lsdp -lbluetooth/' ${S}/bluez-sdp.m4
	cd ${S}
	cat bluez-sdp.m4 bluez-libs.m4 >acinclude.m4
	aclocal; autoconf
}