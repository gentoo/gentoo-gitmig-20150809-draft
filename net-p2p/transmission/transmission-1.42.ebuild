# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-1.42.ebuild,v 1.1 2009/01/01 16:58:20 ssuominen Exp $

EAPI=2

inherit fdo-mime

DESCRIPTION="A Fast, Easy and Free BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com"
SRC_URI="http://download.${PN}bt.com/${PN}/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk nls libnotify"

RDEPEND=">=dev-libs/glib-2.16
	|| ( >=net-misc/curl-7.16.3[ssl] >=net-misc/curl-7.16.3[gnutls] )
	>=dev-libs/openssl-0.9.4
	gtk? ( >=x11-libs/gtk+-2.6
		>=dev-libs/dbus-glib-0.70
		libnotify? ( >=x11-libs/libnotify-0.4.4 ) )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )
	dev-util/pkgconfig"

src_configure() {
	local myconf="--disable-dependency-tracking --with-wx-config=no"

	econf \
		$(use_enable gtk) \
		$(use_enable libnotify) \
		$(use_enable nls) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS

	doinitd "${FILESDIR}"/transmission-daemon
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
