# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dominions2-demo-bin/dominions2-demo-bin-2.08.ebuild,v 1.1 2004/08/08 07:14:18 mr_bones_ Exp $

inherit games

DESCRIPTION="Dominions 2: The Ascension Wars is an epic turn-based fantasy strategy game"
HOMEPAGE="http://www.shrapnelgames.com/Illwinter/d2/"
SRC_URI="http://www.shrapnelgames.com/downloads/dom2demo_linux_x86.tgz"

RESTRICT="nostrip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	media-sound/esound
	kde-base/arts"

S="${WORKDIR}/dominions2demo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod a+x ./dom2demo
}

src_install() {
	dodir "${GAMES_PREFIX_OPT}/${PN}"
	cp -R "${S}/"* "${D}${GAMES_PREFIX_OPT}/${PN}" || die "cp failed"
	games_make_wrapper dominions2-demo ./dom2demo "${GAMES_PREFIX_OPT}/${PN}"
	prepgamesdirs
}
