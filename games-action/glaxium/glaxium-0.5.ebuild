# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/glaxium/glaxium-0.5.ebuild,v 1.4 2004/01/12 20:38:05 vapier Exp $

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
	$(gcc-getCXX) ${FILESDIR}/glx-test.c >& /dev/null
	if [ $? -ne 0 ] ; then
		epatch ${FILESDIR}/${PV}-glx.patch
		append-flags -DGL_GLEXT_LEGACY
	fi
	has_version '~media-video/nvidia-glx-1.0.5328' && epatch ${FILESDIR}/${PV}-another-glx.patch
}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die
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
