# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.74.ebuild,v 1.1 2003/08/18 00:25:58 vapier Exp $

inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://home.t-online.de/home/PeteBernert/"
SRC_URI="http://home.t-online.de/home/PeteBernert/gpupetemesagl${PV//.}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/opengl"

S=${WORKDIR}

src_install() {
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe lib*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPeteMesaGL
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins gpuPeteMesaGL.cfg
	dodoc readme.txt version.txt
	prepgamesdirs
}
