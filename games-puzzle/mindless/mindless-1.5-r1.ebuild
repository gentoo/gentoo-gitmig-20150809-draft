# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mindless/mindless-1.5-r1.ebuild,v 1.1 2004/12/10 12:22:26 mr_bones_ Exp $

inherit games

ORANAME="ORALL06-01-04.txt"
DESCRIPTION="play collectable/trading card games (Magic: the Gathering and possibly others) against other people"
HOMEPAGE="http://mindless.sourceforge.net/"
SRC_URI="mirror://sourceforge/mindless/${P}.tar.gz
	http://mindless.sourceforge.net/${ORANAME}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
RESTRICT="nomirror" # for the card database.

RDEPEND="media-libs/gdk-pixbuf
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack "${P}.tar.gz"
	cp "${DISTDIR}/ORALL06-01-04.txt" "${WORKDIR}" || die "cp failed"
	DATAFILE="${GAMES_DATADIR}/${PN}/${ORANAME}"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin mindless || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins "${WORKDIR}/${ORANAME}" || die "doins failed"
	dodoc CHANGES README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "The first time you start ${PN} you need to tell it where to find"
	einfo "the text database of cards.  This file has been installed at:"
	einfo "${DATAFILE}"
	echo
}
