# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.82.10.ebuild,v 1.4 2004/02/20 07:33:25 mr_bones_ Exp $

inherit games

MY_PV=${PV//./_}
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.de/"
# 0_82_10 was a bugfix release and it uses the 0_82_9 base file.
SRC_URI="http://www.simugraph.com/simutrans/data/simubase-0_82_9exp.zip
	http://www.simugraph.com/simutrans/data/simulinux-${MY_PV}exp.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

DEPEND="app-arch/unzip
	>=sys-apps/sed-4"
RDEPEND="media-libs/libsdl"

S=${WORKDIR}/${PN}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	dogamesbin "${FILESDIR}/simutrans" || die "dogamesbin failed"
	dodir "${dir}"                     || die "dodir failed"
	cp -R * "${D}/${dir}/"             || die "cp failed"
	sed -i \
		-e "s:GENTOO_DIR:${dir}:" "${D}${GAMES_BINDIR}/simutrans" || \
			die "sed simutrans failed"

	prepgamesdirs
	keepdir "${GAMES_PREFIX_OPT}/${PN}/save"
	fperms 2775 "${GAMES_PREFIX_OPT}/${PN}/save"
}
