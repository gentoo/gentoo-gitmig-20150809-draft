# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xye/xye-0.8.0.ebuild,v 1.3 2008/05/02 14:29:58 nyhm Exp $

inherit eutils games

DESCRIPTION="Free version of the classic game Kye"
HOMEPAGE="http://xye.sourceforge.net/"
SRC_URI="mirror://sourceforge/xye/${PN}-source-${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image"

pkg_setup() {
	if ! built_with_use media-libs/sdl-image png ; then
		eerror "You need the png useflag enabled on media-libs/sdl-image."
		eerror "Please emerge media-libs/sdl-image with USE=\"png\""
		die "Missing png useflag."
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
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
