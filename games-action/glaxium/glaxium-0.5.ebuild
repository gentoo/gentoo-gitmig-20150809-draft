# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="OpenGL-based space-ship shoot-em-up style game"
HOMEPAGE="http://xhosxe.free.fr/glaxium/"
SRC_URI="http://xhosxe.free.fr/glaxium/glaxium_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	virtual/x11
	virtual/opengl
	virtual/glu
	virtual/glut
	>=libpng-1.0.0"

S=${WORKDIR}/${PN}_${PV}

pkg_setup() {
	ewarn "This currently only compiles with XFree OpenGL support"
	ewarn "Use \`opengl-update xfree\` before emerging"
}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/${PV}-20021024-Makefile.in ${S}/
}

src_compile() {
	append-flags -DGL_GLEXT_LEGACY
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	make || die
}

src_install() {
	dodir ${GAMES_BINDIR}
	egamesinstall \
		exec_prefix=${D}/${GAMES_PREFIX} \
		datadir=${D}/${GAMES_DATADIR_BASE} \
		|| die
	dodoc README.txt CHANGES.txt
	prepgamesdirs
}
