# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/flobopuyo/flobopuyo-0.20.ebuild,v 1.10 2006/04/11 19:45:53 flameeyes Exp $

inherit toolchain-funcs eutils games

DESCRIPTION="Clone of the famous PuyoPuyo game"
HOMEPAGE="http://www.ios-software.com/?page=projet&quoi=29"
SRC_URI="http://www.ios-software.com/flobopuyo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-libs.patch

	find . -type f -name ".*" -exec rm -f \{\} \;
	sed -i \
		-e "/strip/d" \
		-e "s:^DATADIR=.*:DATADIR=\"${GAMES_DATADIR}/${PN}\":" \
		-e "/^INSTALL_BINDIR/s:/\$(PREFIX)/games:${GAMES_BINDIR}:" \
		-e "s:^CFLAGS=:CFLAGS+=:" \
		-e "/^LDFLAGS=/d" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	use opengl && want_opengl=true || want_opengl=false
	emake CC="$(tc-getCXX)" CXX="$(tc-getCXX)" \
		ENABLE_OPENGL="${want_opengl}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog TODO
	doman man/flobopuyo.6
	prepgamesdirs
}
