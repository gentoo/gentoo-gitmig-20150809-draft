# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-blight-tr64gl/mupen64-blight-tr64gl-0.8.7_pre1.ebuild,v 1.6 2009/01/27 06:23:40 mr_bones_ Exp $

EAPI=1
inherit games

MY_P="tr64gl-${PV/_/-}"
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"
SRC_URI="mirror://gentoo/${MY_P}.so.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

RDEPEND="media-libs/libsdl
	virtual/opengl
	x11-libs/gtk+:1"

S=${WORKDIR}

src_install() {
	exeinto "$(games_get_libdir)"/mupen64/plugins
	doexe ${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
