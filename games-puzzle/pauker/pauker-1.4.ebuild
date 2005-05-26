# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pauker/pauker-1.4.ebuild,v 1.1 2005/05/26 05:34:10 mr_bones_ Exp $

inherit games

DESCRIPTION="A java based flashcard program"
HOMEPAGE="http://pauker.sourceforge.net"
SRC_URI="mirror://sourceforge/pauker/${P}.jar"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	virtual/x11"

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
