# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/parsec/parsec-0197.ebuild,v 1.16 2008/06/25 16:03:26 mr_bones_ Exp $

inherit games

DESCRIPTION="Parsec - there is no safe distance"
HOMEPAGE="http://openparsec.sourceforge.net/"
SRC_URI="ftp://ftp.planetmirror.com/pub/parsec/${PV}/parsec_lan_build${PV}.tar.gz
	ftp://ftp.linuxforum.hu/Games/parsec/parsec_lan_build${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		sys-libs/lib-compat
		virtual/glu
		virtual/glut
		media-libs/openal
		=x11-libs/gtk+-1.2*
	)
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
