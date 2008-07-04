# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ario/ario-1.1.ebuild,v 1.3 2008/07/04 07:36:14 opfer Exp $

EAPI=1
inherit gnome2-utils

DESCRIPTION="a GTK2 MPD (Music Player Daemon) client inspired by Rythmbox"
HOMEPAGE="http://ario-player.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}-player/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi dbus debug"

RDEPEND=">=dev-libs/glib-2.14:2
	gnome-base/libglade:2.0
	net-misc/curl
	net-libs/gnutls
	>=x11-libs/gtk+-2.12:2
	avahi? ( net-dns/avahi )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}"

src_compile() {
	econf \
		$(use_enable avahi) \
		$(use_enable dbus) \
		$(use_enable debug) \
		--disable-audioscrobbler \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
