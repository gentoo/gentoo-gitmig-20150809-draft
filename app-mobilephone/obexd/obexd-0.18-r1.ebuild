# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.18-r1.ebuild,v 1.2 2010/02/20 09:13:48 graaff Exp $

EAPI="2"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug -eds -server"

RDEPEND="eds? ( gnome-extra/evolution-data-server )
	net-wireless/bluez
	>=dev-libs/openobex-1.4
	dev-libs/glib:2
	sys-apps/dbus
	server? ( !app-mobilephone/obex-data-server )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myconf
	if use eds && ! use server ; then
		ewarn "The 'eds' USE flag needs 'server' one to be enabled, disabling 'eds' for now then..."
		myconf="${myconf} --disable-ebook"
	fi

	econf \
		$(use_enable debug) \
		$(use_enable eds ebook) \
		$(use_enable server) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README doc/*.txt
}
