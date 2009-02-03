# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/excido/excido-0.1.5c-r1.ebuild,v 1.8 2009/02/03 23:37:20 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A fast paced action game"
HOMEPAGE="http://icculus.org/excido/"
SRC_URI="http://icculus.org/excido/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc x86"
IUSE=""

DEPEND="dev-games/physfs
	media-libs/libsdl[opengl]
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-libs/openal
	media-libs/freealut"

src_prepare() {
	epatch "${FILESDIR}"/${P}-alut.patch
	sed -i \
		-e '/^CC=/d' \
		-e '/^LIBS/s/-s -Bstatic//' \
		-e 's/-static//' \
		-e 's/-L./`sdl-config --libs`/' \
		-e '/^CFLAGS=/s/CFLAGS/CXXFLAGS+/' \
		-e 's/(CC)/(CXX)/g' \
		-e 's/(CFLAGS)/(CXXFLAGS)/g' \
		-e '/(LIBS)/s/$(LIBS)/$(LDFLAGS) $(LIBS)/' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		CC="$(tc-getCXX)" \
		PREFIX="/usr" \
		BINDIR="${GAMES_BINDIR}/" \
		DATADIR="${GAMES_DATADIR}/${PN}/" \
		|| die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}"
	emake \
		PREFIX="${D}/usr" \
		BINDIR="${D}${GAMES_BINDIR}/" \
		DATADIR="${D}${GAMES_DATADIR}/${PN}/" \
		install || die "emake install failed"
	dodoc BUGS CHANGELOG HACKING README TODO \
		keyguide.txt data/CREDITS data/*.txt
	prepgamesdirs
}
