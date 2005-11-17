# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.76.ebuild,v 1.1 2005/11/17 03:43:33 mr_bones_ Exp $

inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://www.pbernert.com/"
SRC_URI="http://www.pbernert.com/gpupetemesagl${PV//./}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl"

S=${WORKDIR}

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe lib* || die "doexe failed"
	exeinto "${GAMES_LIBDIR}/psemu/cfg"
	doexe cfgPeteMesaGL || die "doexe failed"
	insinto "${GAMES_LIBDIR}/psemu/cfg"
	doins gpuPeteMesaGL.cfg || die "doins failed"
	dodoc readme.txt version.txt
	prepgamesdirs
}
