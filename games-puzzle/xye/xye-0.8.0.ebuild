# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xye/xye-0.8.0.ebuild,v 1.6 2009/01/09 20:15:10 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Free version of the classic game Kye"
HOMEPAGE="http://xye.sourceforge.net/"
SRC_URI="mirror://sourceforge/xye/${PN}-source-${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image[png]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i '/^xye_LDFLAGS/d' Makefile.in || die "sed failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels res || die "doins failed"
	dodoc format.txt template.xye.xml GAMEINTRO.txt AUTHORS \
		ChangeLog README NEWS
	doicon xye.svg
	make_desktop_entry ${PN} Xye
	prepgamesdirs
}
