# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/flobopuyo/flobopuyo-0.20.ebuild,v 1.3 2004/11/12 18:43:52 wolf31o2 Exp $

inherit toolchain-funcs games

DESCRIPTION="Clone of the famous PuyoPuyo game"
HOMEPAGE="http://www.ios-software.com/?page=projet&quoi=29"
SRC_URI="http://www.ios-software.com/flobopuyo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type f -name ".*" -exec rm -f \{\} \;
	sed -i \
		-e "s:^DATADIR=.*:DATADIR=\"${GAMES_DATADIR}/${PN}\":" \
		-e "/^INSTALL_BINDIR/s:/\$(PREFIX)/games:${GAMES_BINDIR}:" \
		-e "/^CC=/s/g++/$(tc-getCXX)/" \
		-e "/^CXX=/s/g++/$(tc-getCXX)/" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog TODO
	prepgamesdirs
}
