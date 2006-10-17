# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/searchtool/searchtool-0.4.4.ebuild,v 1.6 2006/10/17 19:41:25 nyhm Exp $

inherit java-ant-2 java-pkg-2 games

DESCRIPTION="server browser for Internet games"
HOMEPAGE="http://searchtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/searchtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	dev-java/ant"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}

src_compile() {
	eant || die
}

src_install() {
	games_make_wrapper ${PN} "java -jar ${P}.jar" "${GAMES_DATADIR}/${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${P}.jar || die "doins failed"
	dodoc README
	prepgamesdirs
}
