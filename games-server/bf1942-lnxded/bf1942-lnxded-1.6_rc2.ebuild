# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/bf1942-lnxded/bf1942-lnxded-1.6_rc2.ebuild,v 1.1 2004/08/31 02:14:13 vapier Exp $

inherit games eutils

DESCRIPTION="dedicated server for Battlefield 1942"
HOMEPAGE="http://www.eagames.com/official/battlefield/1942/us/editorial/serveradminfaq.jsp"
SRC_URI="bf1942_lnxded-${PV/_/-}.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/libc"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.3dgamers.com/games/battlefield1942/"
	einfo "and put it in ${DISTDIR}"
}

src_unpack() {
	unpack_makeself ${A}
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/bf1942
	dodir ${dir}

	mv * ${D}/${dir}/
	dosym bf1942_lnxded.dynamic ${dir}/bf1942_lnxded
	games_make_wrapper ${PN} ./bf1942_lnxded ${dir}

	prepgamesdirs
}
