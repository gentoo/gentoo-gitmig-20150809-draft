# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.3 2003/12/16 00:16:57 avenj Exp $

inherit games flag-o-matic gcc

DESCRIPTION="OpenGL-based space-ship shoot-em-up style game"
HOMEPAGE="http://xhosxe.free.fr/glaxium/"
SRC_URI="http://xhosxe.free.fr/glaxium/glaxium_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.4
	virtual/x11
	virtual/opengl
	virtual/glu
	virtual/glut
	>=media-libs/libpng-1.0.0"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	ebegin "Checking if glx patch is needed"
	$(gcc-getCXX) ${FILESDIR}/glx-test.c
	local ret=$?
	[ ${ret} -eq 0 ] || epatch ${FILESDIR}/${PV}-glx.patch
	eend ${ret}
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
