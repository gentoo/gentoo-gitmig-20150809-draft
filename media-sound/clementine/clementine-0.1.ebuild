# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/clementine/clementine-0.1.ebuild,v 1.1 2010/02/22 19:57:21 ssuominen Exp $

EAPI=2
inherit eutils gnome2-utils qt4-r2

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]
	x11-libs/qt-opengl:4
	media-libs/liblastfm
	x11-libs/libnotify
	media-libs/xine-lib
	media-libs/taglib
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:application-x-${PN}:${PN}:" \
		dist/${PN}.desktop || die

	qt4-r2_src_prepare
}

src_install() {
	dobin src/${PN} || die

	local res
	for res in 16 32 64; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins dist/${PN}_${res}.png ${PN}.png || die
	done

	domenu dist/${PN}.desktop

	dodoc TODO
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
