# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-0.4.1.ebuild,v 1.1 2003/09/20 08:56:04 liquidx Exp $

inherit gnome2

DESCRIPTION="Gnome2 Bluetooth integration suite."
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"
SRC_URI="http://usefulinc.com/software/gnome-bluetooth/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gconf-2
	>=dev-util/gob-2
	>=dev-libs/glib-2
	>=dev-libs/openobex-1
	>=net-wireless/libbtctl-0.3"

DOCS="README"
MAKEOPTS="${MAKEOPTS} -j1"
