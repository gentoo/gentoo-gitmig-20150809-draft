# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/planeshift/planeshift-0.2.010-r1.ebuild,v 1.4 2004/02/03 20:44:33 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/${PN}"
HOMEPAGE="http://www.planeshift.it/"
DESCRIPTION="virtual fantasy world MMORPG"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.bz2"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2 | Planeshift"
SLOT="0"
IUSE=""

DEPEND="net-ftp/curl
	dev-games/crystalspace
	dev-games/cel"

export PLANESHIFT_PREFIX=${PLANESHIFT_PREFIX:-${GAMES_PREFIX_OPT}/${PN}}
export CRYSTAL_PREFIX=${CRYSTAL_PREFIX:-${GAMES_PREFIX_OPT}/crystal}
export CEL_PREFIX=${CEL_PREFIX:-${CRYSTAL_PREFIX}}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fix-cast.diff
}

src_compile() {
	env \
		-uCEL \
		-uCSCONFPATH \
		CEL=${CEL_PREFIX} \
		CSCONFPATH=${CEL_PREFIX} \
		./configure --prefix=${PLANESHIFT_PREFIX} --with-cs-prefix=${CRYSTAL_PREFIX} || die
	jam || die
}

src_install() {
	rm -rf src mk config* ac* Jam* install-sh mkinstalldirs \
		missing autogen.sh depcomp Makefile.* ltmain.sh \
		out support include

	dodir ${PLANESHIFT_PREFIX}
	mv * ${D}/${PLANESHIFT_PREFIX}

	dogamesbin ${FILESDIR}/planeshift
	dosed "s:GENTOO_CRYSTAL_DIR:${CRYSTAL_PREFIX}:" ${GAMES_BINDIR}/planeshift
	dosed "s:GENTOO_CEL_DIR:${CRYSTAL_PREFIX}:" ${GAMES_BINDIR}/planeshift
	dosed "s:GENTOO_PLANESHIFT_DIR:${PLANESHIFT_PREFIX}:" ${GAMES_BINDIR}/planeshift

	prepgamesdirs
}
