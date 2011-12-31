# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gmchess/gmchess-0.29.6.ebuild,v 1.1 2011/12/31 19:39:32 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="Chinese chess with gtkmm and c++"
HOMEPAGE="http://code.google.com/p/gmchess/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-cpp/gtkmm:2.4"

src_prepare() {
	sed -i -e '/Encoding=/d' data/${PN}.desktop.in || die
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-static \
		--localedir='/usr/share/locale' || die
}

src_install() {
	emake DESTDIR="${D}" \
		itlocaledir='/usr/share/locale' \
		pixmapsdir='/usr/share/pixmaps' \
		desktopdir='/usr/share/applications' \
		install || die
	dodoc AUTHORS NEWS README
	find "${D}" -name '*.la' -exec rm -f '{}' +
	prepgamesdirs
}
