# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.84.16.4.ebuild,v 1.4 2006/09/19 19:52:10 wolf31o2 Exp $

inherit games

MY_PV=${PV//./_}
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.de/"
SRC_URI="http://hajo.simutrans.com/download/simubase-${MY_PV/_4/_2}.zip
	http://hajo.simutrans.com/download/simulinux-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
	)"

S=${WORKDIR}/${PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	games_make_wrapper simutrans ./simutrans "${dir}"
	keepdir "${dir}/save"
	cp -R * "${D}/${dir}/" || die "cp failed"
	find "${D}/${dir}/"{text,font} -type f -print0 | xargs -0 chmod a-x
	prepgamesdirs
	fperms 2775 "${dir}/save"
}
