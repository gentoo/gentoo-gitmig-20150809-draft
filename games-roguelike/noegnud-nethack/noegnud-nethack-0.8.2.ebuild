# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-nethack/noegnud-nethack-0.8.2.ebuild,v 1.5 2004/03/21 18:15:07 jhuebel Exp $ 

inherit games

VAR_NAME=nethack
VAR_SNAME=nh
VAR_DVER=3.4.2
VAR_VER=${VAR_DVER//.}
VAR_TAR=${VAR_NAME}-${VAR_VER}.tgz
DESCRIPTION="an alternate 2D/3D graphical user interface for NetHack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_linux_src-minimal.tar.bz2
	mirror://sourceforge/${VAR_NAME}/${VAR_TAR}"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="media-libs/libsdl
	dev-util/yacc"
RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl
	games-roguelike/noegnud-data"

S=${WORKDIR}/noegnud-${PV}/variants

src_unpack() {
	unpack noegnud-${PV}_linux_src-minimal.tar.bz2
	ln -s ${DISTDIR}/${VAR_TAR} noegnud-${PV}/variants/tarballs/${VAR_TAR}
}

src_compile() {
	make ${VAR_SNAME}${VAR_VER} PREFIX=${GAMES_PREFIX} || die
}

src_install() {
	make install_${VAR_SNAME}${VAR_VER} PREFIX=${D}/${GAMES_PREFIX} || die

	cd ${D}/${GAMES_BINDIR}
	# we do this cause sometimes the installed package thinks it's a diff version :)
	local tver="`ls noegnud-*-${VAR_NAME}-${VAR_DVER} | cut -d- -f2`"
	rm noegnud-${VAR_NAME}-${VAR_DVER}
	mv noegnud-${tver}-${VAR_NAME}-${VAR_DVER} noegnud-${VAR_NAME}
	dosed "/^HACKDIR/s:=.*:=${GAMES_LIBDIR}/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}:" ${GAMES_BINDIR}/noegnud-${VAR_NAME}

	dodir ${GAMES_DATADIR}/noegnud_data
	cp -r ${S}/../data/* ${D}/${GAMES_DATADIR}/noegnud_data/
	dosym ${GAMES_DATADIR}/noegnud_data ${GAMES_LIBDIR}/noegnud-${tver}/data

	keepdir ${GAMES_LIBDIR}/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}/save

	prepgamesdirs
	chmod -R g+w ${D}/${GAMES_LIBDIR}/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}
}
