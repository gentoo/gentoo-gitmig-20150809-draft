# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetexgl2/psemu-gpupetexgl2-2.0.5-r2.ebuild,v 1.6 2005/03/06 05:59:39 mr_bones_ Exp $

inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://www.pbernert.com/"
SRC_URI="http://home.t-online.de/home/PeteBernert/gpupetexgl${PVR//.}.tar.gz
	http://home.t-online.de/home/PeteBernert/pete_ogl2_shader_simpleblur.zip
	http://home.t-online.de/home/PeteBernert/pete_ogl2_shader_scale2x.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe lib* || die "doexe failed"
	exeinto "${GAMES_LIBDIR}/psemu/cfg"
	doexe cfgPeteXGL2 || die "doexe failed"
	insinto "${GAMES_LIBDIR}/psemu/cfg"
	doins gpuPeteXGL2.cfg || die "doins failed"
	# now do our shader files!
	insinto "${GAMES_LIBDIR}/psemu/shaders"
	doins *.fp *.vp *.slf *.slv || die "doins failed"
	dodoc *.txt
	prepgamesdirs
}
