# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/bf1942-lnxded/bf1942-lnxded-1.5.ebuild,v 1.1 2003/12/28 20:48:20 vapier Exp $

inherit games

DESCRIPTION="dedicated server for Battlefield 1942"
HOMEPAGE="http://www.eagames.com/official/battlefield/1942/us/editorial/serveradminfaq.jsp"
SRC_URI="bf1942_lnxded-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

RDEPEND="virtual/glibc
	sys-devel/gcc"

S=${WORKDIR}/bf1942

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.3dgamers.com/dl/games/battlefield1942/bf1942_lnxded-${PV}.tar.bz2.html"
	einfo "and put it in ${DISTDIR}"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/bf1942
	dodir ${dir}

	mv * ${D}/${dir}/
	dosym bf1942_lnxded.dynamic ${dir}/bf1942_lnxded
	dogamesbin ${FILESDIR}/bf1942-lnxded
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/bf1942-lnxded

	prepgamesdirs
}
