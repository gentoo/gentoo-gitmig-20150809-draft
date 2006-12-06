# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xbattle/xbattle-5.4.1.ebuild,v 1.9 2006/12/06 21:10:43 wolf31o2 Exp $

inherit games

DESCRIPTION="A multi-player game of strategy and coordination"
HOMEPAGE="http://www.cgl.uwaterloo.ca/~jdsteele/xbattle.html"
SRC_URI="ftp://cns-ftp.bu.edu/pub/xbattle/${P}.tar.gz"

LICENSE="xbattle"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libX11
	!games-strategy/xbattleai"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-libs/libX11
	app-text/rman
	x11-misc/imake"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/export/home/lesher/:${GAMES_DATADIR}/${PN}/:" Imakefile \
		|| die "sed Imakefile failed"
}

src_compile() {
	xmkmf || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xbattle || die "dogamesbin failed"
	newgamesbin tutorial1 xbattle-tutorial1 || die "newgamesbin failed"
	newgamesbin tutorial2 xbattle-tutorial2 || die "newgamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r xbas/ xbos/ xbts/ "${D}${GAMES_DATADIR}/${PN}/" || die "cp failed"
	newman xbattle.man xbattle.6
	dodoc README xbattle.dot
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo 'You may be interested by these tutorials:'
	einfo '    xbattle-tutorial1'
	einfo '    xbattle-tutorial2'
}
