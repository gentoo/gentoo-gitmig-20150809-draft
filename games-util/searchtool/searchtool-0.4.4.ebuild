# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/searchtool/searchtool-0.4.4.ebuild,v 1.1 2003/09/10 18:53:23 vapier Exp $

inherit games

DESCRIPTION="server browser for Internet games"
HOMEPAGE="http://searchtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/searchtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-java/ant"
RDEPEND="virtual/jre"

S=${WORKDIR}/${PN}

src_compile() {
	ant || die
	sed \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_P:${P}:" \
		${FILESDIR}/searchtool > searchtool
}

src_install() {
	insinto ${GAMES_DATADIR}/${PN}
	doins ${P}.jar
	dogamesbin searchtool
	dodoc README
	prepgamesdirs
}
