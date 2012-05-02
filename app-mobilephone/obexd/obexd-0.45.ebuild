# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.45.ebuild,v 1.6 2012/05/02 20:10:09 jdhore Exp $

EAPI="4"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~ppc x86"
IUSE="-eds nokia -server usb"

RDEPEND="eds? ( gnome-extra/evolution-data-server )
	!eds? ( dev-libs/libical )
	>=net-wireless/bluez-4.99
	>=dev-libs/openobex-1.4
	>=dev-libs/glib-2.16:2
	sys-apps/dbus
	server? ( !app-mobilephone/obex-data-server )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-arch/xz-utils"

src_configure() {
	econf \
		--disable-debug \
		$(use_with eds phonebook ebook) \
		$(use_enable nokia pcsuite) \
		$(use_enable server) \
		$(use_enable usb)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README doc/*.txt
}
