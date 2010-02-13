# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.21.ebuild,v 1.1 2010/02/13 18:33:18 pacho Exp $

EAPI="2"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug eds"

RDEPEND="eds? ( gnome-extra/evolution-data-server )
	net-wireless/bluez
	>=dev-libs/openobex-1.4
	dev-libs/glib:2
	sys-apps/dbus
	!app-mobilephone/obex-data-server"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with eds phonebook ebook)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README doc/*.txt
}
