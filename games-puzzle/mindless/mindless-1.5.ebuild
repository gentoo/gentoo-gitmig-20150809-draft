# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mindless/mindless-1.5.ebuild,v 1.1 2004/07/25 03:11:12 mr_bones_ Exp $

inherit games

DESCRIPTION="play collectable/trading card games (Magic: the Gathering and possibly others) against other people"
HOMEPAGE="http://mindless.sourceforge.net/"
SRC_URI="mirror://sourceforge/mindless/${P}.tar.gz
	 http://home.dmv.com/~rast/patch.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
RESTRICT="nomirror"

RDEPEND="media-libs/gdk-pixbuf"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin mindless mindless-bin || die "newgamesbin failed"
	dogamesbin ${FILESDIR}/mindless || die "dogamesbin failed"
	sed -i \
		-e "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" \
		"${D}${GAMES_BINDIR}/mindless" \
		|| die "sed failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins "${WORKDIR}/"*.dat || die "doins failed"
	dodoc CHANGES README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "mindless is now a wrapper that searches"
	einfo "for cardinfo files and then runs mindless-bin."
	einfo "If you wish to run mindless yourself, please"
	einfo "use mindless-bin."
	echo
}
