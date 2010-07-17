# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/atanks/atanks-4.6.ebuild,v 1.3 2010/07/17 09:17:22 fauli Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Worms and Scorched Earth-like game"
HOMEPAGE="http://atanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/atanks/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/allegro[X]"

src_prepare() {
	find . -type f -name ".directory" -exec rm -vf '{}' +
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}"
		INSTALLDIR="${GAMES_DATADIR}/${PN}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r button misc missile sound stock tank tankgun text title \
		unicode.dat *.txt \
		|| die "doins failed"
	doicon ${PN}.png
	make_desktop_entry atanks "Atomic Tanks"
	dodoc Changelog README TODO
	prepgamesdirs
}
