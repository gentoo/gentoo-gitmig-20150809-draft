# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-data/quake1-data-2.40.ebuild,v 1.1 2005/10/30 05:57:41 vapier Exp $

inherit games

DESCRIPTION="iD Software's Quake 1 ... the data files"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds q101_int.1
}

src_unpack() {
	echo ">>> Unpacking q101_int.1 to ${PWD}"
	lha xqf "${CDROM_ROOT}"/q101_int.1 || die "failure unpacking q101_int.1"
}

src_install() {
	insinto ${GAMES_DATADIR}/quake1/id1
	doins id1/* || die "doins pak files"
	dodoc *.txt
	prepgamesdirs
}
