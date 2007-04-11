# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/parsec/parsec-0197.ebuild,v 1.14 2007/04/11 18:20:25 nyhm Exp $

inherit games

DESCRIPTION="Parsec - there is no safe distance"
HOMEPAGE="http://openparsec.sourceforge.net/"
SRC_URI="http://public.www.planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	ftp://ftp.planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	http://ftp.webmonster.de/pub/parsec/parsec_lan_build${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/openal
	=x11-libs/gtk+-1.2*
	x86? ( sys-libs/lib-compat )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-compat
	)"

S=${WORKDIR}/${PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	games_make_wrapper ${PN} ./launcher "${dir}"
	dodir "${dir}"
	# preserve execute permissions.  bug #119081
	cp -r * "${D}${dir}" || die "cp failed"
	prepgamesdirs
}
