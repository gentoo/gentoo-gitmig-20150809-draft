# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libbtctl/libbtctl-0.3.ebuild,v 1.2 2003/09/19 21:30:50 liquidx Exp $

inherit gnome2

DESCRIPTION="A GObject wrapper for Bluetooth functionality"
HOMEPAGE="http://usefulinc.com/software/gnome-bluetooth/"
SRC_URI="http://usefulinc.com/software/gnome-bluetooth/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2
	>=net-wireless/bluez-utils-2
	>=net-wireless/bluez-libs-2
	>=net-wireless/bluez-sdp-1"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="README"
