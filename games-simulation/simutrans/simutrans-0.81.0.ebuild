# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.81.0.ebuild,v 1.1 2003/09/11 12:22:49 vapier Exp $

inherit games

MY_PV=${PV//./_}
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.de/"
SRC_URI="http://www.s-line.de/homepages/simutrans/simutrans/data/simubase-${MY_PV}.zip
	http://www.s-line.de/homepages/simutrans/simutrans/data/simulinux-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

DEPEND=""
RDEPEND="media-libs/libsdl"

S=${WORKDIR}/${PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	mv * ${D}/${dir}/

	dogamesbin ${FILESDIR}/simutrans
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/simutrans

	prepgamesdirs
}
