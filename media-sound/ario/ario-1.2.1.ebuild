# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ario/ario-1.2.1.ebuild,v 1.1 2009/01/28 19:30:58 angelos Exp $

EAPI=1
inherit gnome2-utils

DESCRIPTION="a GTK2 MPD (Music Player Daemon) client inspired by Rythmbox"
HOMEPAGE="http://ario-player.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}-player/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audioscrobbler dbus debug idle libnotify nls python zeroconf"

RDEPEND=">=dev-libs/glib-2.14:2
	gnome-base/libglade:2.0
	net-misc/curl
	net-libs/gnutls
	>=x11-libs/gtk+-2.12:2
	audioscrobbler? ( net-libs/libsoup:2.4 )
	dbus? ( dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	python? ( dev-python/pygtk
		dev-python/pygobject )
	zeroconf? ( net-dns/avahi )"
DEPEND="sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable audioscrobbler) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable idle mpdidle) \
		$(use_enable libnotify notify) \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable zeroconf avahi)

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
