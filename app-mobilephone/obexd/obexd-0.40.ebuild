# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.40.ebuild,v 1.2 2011/05/28 13:21:57 phajdan.jr Exp $

EAPI="3"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
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
		$(use_enable nokia nokia-backup) \
		$(use_enable server) \
		$(use_enable usb)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README doc/*.txt || die
}
