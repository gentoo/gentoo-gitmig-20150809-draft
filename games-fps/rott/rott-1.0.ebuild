# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/rott/rott-1.0.ebuild,v 1.7 2005/09/16 01:19:49 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Rise of the Triad for Linux!"
HOMEPAGE="http://www.icculus.org/rott/"
SRC_URI="http://www.icculus.org/rott/releases/${P}.tar.gz
	http://filesingularity.timedoctor.org/swdata.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P}/rott

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-custom-datapath.patch
}

src_compile() {
	make clean || die
	emake -j1 EXTRACFLAGS="${CFLAGS} -DDATADIR=\\\"${GAMES_DATADIR}/${PN}/\\\"" \
		|| die "emake failed"
}

src_install() {
	dogamesbin rott || die "dogamesbin failed"
	dodoc *.txt ../{README,readme.txt}
	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}"/${PN}
	doins *.dmo huntbgin.* remote1.rts || die "doins failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "The shareware version has been installed."
	einfo "To play the full version, just copy the"
	einfo "data files to ${GAMES_DATADIR}/${PN}/"
}
