# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cervi/cervi-0.0.3.ebuild,v 1.8 2009/01/18 19:58:12 tupone Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="A multiplayer game where players drive a worm and try not to collide with anything"
SRC_URI="http://tomi.nomi.cz/download/${P}.tar.bz2"
HOMEPAGE="http://tomi.nomi.cz/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-sound/esound
	media-sound/timidity++"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "/^CFLAGS/ s:-Wall:${CFLAGS}:" \
		-e "/^CXXFLAGS/ s:-Wall:${CXXFLAGS}:" Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	emake \
		CXX=$(tc-getCXX) \
		bindir="${GAMES_BINDIR}" \
		datadir="${GAMES_DATADIR}/${PN}" \
		|| die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" || die "dodir failed"
	emake \
		bindir="${D}/${GAMES_BINDIR}" \
		datadir="${D}/${GAMES_DATADIR}/${PN}" install \
		|| die "emake install failed"
	dodoc AUTHORS changelog README
	prepgamesdirs
}
