# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.76.ebuild,v 1.3 2007/04/09 16:54:30 nyhm Exp $

inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://www.pbernert.com/"
SRC_URI="http://www.pbernert.com/gpupetemesagl${PV//./}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

DEPEND="virtual/opengl"

S=${WORKDIR}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe lib* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPeteMesaGL || die "doexe failed"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins gpuPeteMesaGL.cfg || die "doins failed"
	dodoc readme.txt version.txt
	prepgamesdirs
}
