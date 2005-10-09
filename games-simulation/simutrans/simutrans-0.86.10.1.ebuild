# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.86.10.1.ebuild,v 1.1 2005/10/09 05:34:53 mr_bones_ Exp $

inherit games

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI="http://64.simutrans.com/simulinux-86-10-1.zip
	http://64.simutrans.com/simupak64-86-10.zip
	http://64.simutrans.com/food64-86-06.zip
	http://64.simutrans.com/waste64-86-03.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
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
