# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.84.16.2.ebuild,v 1.1 2004/10/06 09:05:53 mr_bones_ Exp $

inherit games

MY_PV=${PV//./_}
S="${WORKDIR}/${PN}"
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.de/"
SRC_URI="http://hajo.simutrans.com/download/simubase-${MY_PV}.zip
	http://hajo.simutrans.com/download/simulinux-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libsdl
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
	)"

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	games_make_wrapper simutrans ./simutrans "${dir}"
	keepdir "${dir}/save"
	cp -R * "${D}/${dir}/" || die "cp failed"
	find "${D}/${dir}/"{text,font} -type f | xargs chmod a-x
	prepgamesdirs
	fperms 2775 "${dir}/save"
}
