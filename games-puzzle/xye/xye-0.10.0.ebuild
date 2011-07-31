# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xye/xye-0.10.0.ebuild,v 1.1 2011/07/31 04:41:06 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Free version of the classic game Kye"
HOMEPAGE="http://xye.sourceforge.net/"
SRC_URI="mirror://sourceforge/xye/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-fonts/dejavu"

src_prepare() {
	sed -i -e '/^xye_LDFLAGS/d' Makefile.am || die
	eautoreconf
}

src_install() {
	dogamesbin "${PN}" || die
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels res || die
	rm -f "${D}${GAMES_DATADIR}/${PN}"/res/DejaVuSans*
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}/${PN}"/res/
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}/${PN}"/res/
	dodoc readme.txt GAMEINTRO.txt AUTHORS ChangeLog README NEWS
	doicon xye.svg
	make_desktop_entry ${PN} Xye
	prepgamesdirs
}
