# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.42.ebuild,v 1.3 2011/08/31 22:46:15 chainsaw Exp $

EAPI="4"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~x86"
IUSE="debug -eds nokia -server usb"

RDEPEND="eds? ( gnome-extra/evolution-data-server )
	!eds? ( dev-libs/libical )
	net-wireless/bluez
	>=dev-libs/openobex-1.4
	>=dev-libs/glib-2.16:2
	sys-apps/dbus
	server? ( !app-mobilephone/obex-data-server )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with eds phonebook ebook) \
		$(use_enable nokia pcsuite) \
		$(use_enable server) \
		$(use_enable usb)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README doc/*.txt
}
