# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.5.ebuild,v 1.2 2004/08/30 23:28:37 dholm Exp $

inherit gcc eutils games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://linuz.sns.it/~max/powwow/"
SRC_URI="http://linuz.sns.it/~max/powwow/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

POWWOWDIR="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-copyfile.patch"
}

src_compile() {
	emake \
		CC="$(gcc-getCC)" \
		CFLAGS="${CFLAGS} -DUSE_REGEXP -DPOWWOW_DIR=\"\\\"${POWWOWDIR}\\\"\"" \
		LDFLAGS="-lncurses" \
		powwow movie \
		|| die "emake failed"
}

src_install () {
	dogamesbin powwow || die "dogamesbin failed"
	newgamesbin movie movie_play
	dosym movie_play "${GAMES_BINDIR}/movie2ascii"
	insinto "${POWWOWDIR}"
	doins powwow.help COPYING || die "doins failed"
	dodoc README.* powwow.doc powwow-1.2.5.lsm Compile.how \
		Hacking Config.demo Changelog
	prepgamesdirs
}
