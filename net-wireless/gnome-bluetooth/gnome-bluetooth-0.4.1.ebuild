# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.4.1.ebuild,v 1.15 2004/10/16 20:40:47 liquidx Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome2 Bluetooth integration suite."
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"
SRC_URI="http://usefulinc.com/software/gnome-bluetooth/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
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
	>=dev-libs/glib-2
	>=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.7
	<=net-wireless/libbtctl-0.3"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}/libegg/libegg
	epatch ${FILESDIR}/${P}-gtk24.patch
	cp ${S}/libegg/libegg/util/eggmarshalers.h ${S}/libegg/libegg/toolbar
	sed -i -e 's/-lsdp/-lbluetooth/' ${S}/acinclude.m4
	cd ${S}; aclocal; autoconf
}
