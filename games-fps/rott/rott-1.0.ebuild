# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/rott/rott-1.0.ebuild,v 1.3 2004/02/20 06:40:07 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Rise of the Triad for Linux!"
HOMEPAGE="http://www.icculus.org/rott/"
SRC_URI="http://www.icculus.org/rott/releases/${P}.tar.gz
	http://filesingularity.timedoctor.org/swdata.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

S=${WORKDIR}/${P}/rott

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-custom-datapath.patch
}

src_compile() {
	make clean || die
	make EXTRACFLAGS="${CFLAGS} -DDATADIR=\\\"${GAMES_DATADIR}/${PN}/\\\"" || die
}

src_install() {
	dogamesbin rott
	dodoc *.txt ../{README,readme.txt}

	cd ${WORKDIR}
	insinto ${GAMES_DATADIR}/${PN}
	doins *.dmo huntbgin.* remote1.rts

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "The shareware version has been installed."
	einfo "To play the full version, just copy the"
	einfo "data files to ${GAMES_DATADIR}/${PN}/"
}
