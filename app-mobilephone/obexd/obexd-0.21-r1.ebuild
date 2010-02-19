# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexd/obexd-0.21-r1.ebuild,v 1.1 2010/02/19 13:26:39 pacho Exp $

EAPI="2"

DESCRIPTION="OBEX Server and Client"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
#IUSE="debug eds -server"
# 'eds' USE flag disabled until upstream fixes bug 305063
IUSE="debug -server"

RDEPEND="net-wireless/bluez
	>=dev-libs/openobex-1.4
	dev-libs/glib:2
	sys-apps/dbus
	server? ( !app-mobilephone/obex-data-server )"
#	eds? ( gnome-extra/evolution-data-server )

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
#	local myconf
#	if use eds; then
#		myconf="${myconf} --with-phonebook=ebook"
#	else
#		myconf="${myconf} --with-phonebook=dummy"
#	fi
	econf \
		$(use_enable debug) \
		$(use_enable server)
#		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README doc/*.txt
}
