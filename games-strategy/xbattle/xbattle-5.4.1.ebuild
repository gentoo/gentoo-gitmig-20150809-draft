# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xbattle/xbattle-5.4.1.ebuild,v 1.2 2004/02/10 13:22:02 mr_bones_ Exp $

inherit games

DESCRIPTION="A multi-player game of strategy and coordination"
HOMEPAGE="http://cns-web.bu.edu/pub/xpip/html/xbattle.html"
SRC_URI="ftp://cns-ftp.bu.edu/pub/xbattle/${P}.tar.gz"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64"
LICENSE="xbattle"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:/export/home/lesher/:${GAMES_DATADIR}/${PN}/:" Imakefile || \
			die "sed Imakefile failed"
}

src_compile() {
	xmkmf || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xbattle                      || die "dogamesbin failed"
	newgamesbin tutorial1 xbattle-tutorial1 || die "newgamesbin failed"
	newgamesbin tutorial2 xbattle-tutorial2 || die "newgamesbin failed"
	dodir ${GAMES_DATADIR}/${PN}            || die "dodir failed"
	cp -r xbas/ xbos/ xbts/ ${D}${GAMES_DATADIR}/${PN}/ || die "cp failed"
	newman xbattle.man xbattle.6            || die "newman failed"
	dodoc README xbattle.dot                || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo 'You may be interested by these tutorials:'
	einfo '    xbattle-tutorial1'
	einfo '    xbattle-tutorial2'
}
