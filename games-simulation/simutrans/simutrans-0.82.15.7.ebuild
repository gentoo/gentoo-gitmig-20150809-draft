# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.82.15.7.ebuild,v 1.1 2004/01/13 02:45:13 mr_bones_ Exp $

inherit games

MY_PV=${PV//./_}
S="${WORKDIR}/${PN}"
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.de/"
SRC_URI="http://www.s-line.de/homepages/simutrans/data/simubase-${MY_PV}exp.zip
	http://www.s-line.de/homepages/simutrans/data/simulinux-${MY_PV}exp.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl"

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	games_make_wrapper simutrans ./simutrans "${dir}"
	dodir "${dir}"                     || die "dodir failed"
	cp -R * "${D}/${dir}/"             || die "cp failed"
	find "${D}/${dir}/text" -type f | xargs chmod a-x
	prepgamesdirs
	keepdir "${GAMES_PREFIX_OPT}/${PN}/save"
	fperms 2775 "${GAMES_PREFIX_OPT}/${PN}/save"
}
