# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.5.ebuild,v 1.5 2005/06/15 18:56:17 wolf31o2 Exp $

inherit toolchain-funcs eutils games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://linuz.sns.it/~max/powwow/"
SRC_URI="http://linuz.sns.it/~max/powwow/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
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
		CC="$(tc-getCC)" \
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
	doins powwow.help || die "doins failed"
	dodoc README.* powwow.doc powwow-1.2.5.lsm Compile.how \
		Hacking Config.demo Changelog
	prepgamesdirs
}
