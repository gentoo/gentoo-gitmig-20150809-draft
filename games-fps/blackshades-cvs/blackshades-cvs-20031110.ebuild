# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/blackshades-cvs/blackshades-cvs-20031110.ebuild,v 1.2 2004/02/20 06:40:07 mr_bones_ Exp $

#ECVS_PASS="anonymous"
#ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_MODULE="blackshades"
#inherit cvs
inherit games

DESCRIPTION="you control a psychic bodyguard, and try to protect the VIP"
HOMEPAGE="http://www.wolfire.com/blackshades.html http://www.icculus.org/blackshades/"
SRC_URI="http://filesingularity.timedoctor.org/Textures.tar.bz2
	mirror://gentoo/blackshades-${PV}.tar.bz2"

LICENSE="blackshades"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=sys-apps/sed-4
	media-libs/libvorbis
	media-libs/openal
	media-libs/libsdl
	virtual/opengl"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	if [ -z "${ECVS_SERVER}" ] ; then
		unpack blackshades-${PV}.tar.bz2
	else
		cvs_src_unpack
	fi
	cd ${WORKDIR}
	unpack Textures.tar.bz2
	cd ${S}
	sed -i "/^CFLAGS/s:$: ${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_compile() {
	make || die
}

src_install() {
	dogamesbin ${FILESDIR}/blackshades
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/blackshades
	newgamesbin objs/blackshades blackshades-bin

	dodir ${GAMES_DATADIR}/${PN}
	rm -rf Data/Textures
	mv ${WORKDIR}/Textures Data/
	cp -rf Data ${D}/${GAMES_DATADIR}/${PN}/

	dodoc IF_THIS_IS_A_README_YOU_HAVE_WON Readme TODO uDevGame_Readme
	prepgamesdirs
}
