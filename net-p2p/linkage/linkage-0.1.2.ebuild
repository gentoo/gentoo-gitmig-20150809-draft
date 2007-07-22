# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/linkage/linkage-0.1.2.ebuild,v 1.2 2007/07/22 14:43:26 drac Exp $

inherit fdo-mime

DESCRIPTION="BitTorrent client written in C++ using gtkmm and libtorrent."
HOMEPAGE="http://code.google.com/p/linkage"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="upnp"

RDEPEND=">=net-libs/rb_libtorrent-0.12
	>=dev-cpp/gtkmm-2.10
	>=x11-libs/libnotify-0.4.2
	>=net-misc/curl-7.14
	dev-libs/dbus-glib
	upnp? ( net-libs/libupnp )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
