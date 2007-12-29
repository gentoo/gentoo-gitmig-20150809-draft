# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-gnome/bluez-gnome-0.15.ebuild,v 1.3 2007/12/29 01:59:59 betelgeuse Exp $

EAPI=1

inherit autotools gnome2

DESCRIPTION="Bluetooth helpers for GNOME"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="+hal +libnotify"
DEPEND=">=dev-libs/glib-2.0
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	>=gnome-base/gconf-2.6
	>=dev-libs/dbus-glib-0.60
	hal? ( sys-apps/hal )
	x11-proto/xproto
	>=x11-libs/gtk+-2.6"
RDEPEND="=net-wireless/bluez-utils-3*
	${DEPEND}"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}/0.15-optional-features.patch"
	eautoreconf
	G2CONF="--disable-desktop-update
		--disable-mime-update
		$(use_enable hal)
		$(use_enable libnotify)"
}

DOCS="AUTHORS README NEWS ChangeLog"
