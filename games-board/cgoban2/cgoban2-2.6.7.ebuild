# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban2/cgoban2-2.6.7.ebuild,v 1.1 2004/11/19 08:34:47 mr_bones_ Exp $

inherit games

DESCRIPTION="A Java client for the Kiseido Go Server, and a SGF editor"
HOMEPAGE="http://kgs.kiseido.com/"
SRC_URI="http://kgs.kiseido.com/cgoban-unix-${PV}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.3
	virtual/x11"

S="${WORKDIR}/cgoban"

src_install() {
	dodir "${GAMES_BINDIR}"
	sed -e "s:INSTALL_DIR:${GAMES_DATADIR}/${PN}:" \
		"${FILESDIR}/${PN}" > "${D}${GAMES_BINDIR}/${PN}" \
		|| die "sed failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins cgoban.jar || die "doins failed"
	prepgamesdirs
}
