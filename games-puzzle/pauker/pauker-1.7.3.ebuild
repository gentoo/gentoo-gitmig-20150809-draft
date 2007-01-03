# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pauker/pauker-1.7.3.ebuild,v 1.1 2007/01/03 12:17:24 mr_bones_ Exp $

inherit games

DESCRIPTION="A java based flashcard program"
HOMEPAGE="http://pauker.sourceforge.net"
SRC_URI="mirror://sourceforge/pauker/${P}.jar"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	mkdir -p "${S}"
	cp "${DISTDIR}/${P}.jar" "${S}" || die "cp failed"
}

src_install() {
	local jar="pauker.jar"
	insinto "${GAMES_PREFIX_OPT}/${PN}"
	newins "${P}.jar" ${jar} || die "newins failed"
	games_make_wrapper ${PN} "java -jar ./${jar}" "${GAMES_PREFIX_OPT}/${PN}"
	prepgamesdirs
}
