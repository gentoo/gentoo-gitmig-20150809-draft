# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-slashem/noegnud-slashem-0.8.2.ebuild,v 1.3 2004/02/03 20:46:56 mr_bones_ Exp $ 

inherit eutils games

VAR_NAME=slashem
VAR_SNAME=se
VAR_DVER=0.0.7E3
VAR_VER=007e3
VAR_TAR=${VAR_SNAME}${VAR_VER}.tar.gz
DESCRIPTION="an alternate 2D/3D graphical user interface for SLASH'EM"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_linux_src-minimal.tar.bz2
	mirror://sourceforge/noegnud/noegnud-${PV}_noegnud-${PV}.se${VAR_VER/e/E}.diff.gz
	mirror://sourceforge/${VAR_NAME}/${VAR_TAR}"

KEYWORDS="x86"
LICENSE="nethack"
SLOT="0"
IUSE=""

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
	epatch ${DISTDIR}/noegnud-${PV}_noegnud-${PV}.${VAR_SNAME}${VAR_VER/e/E}.diff.gz
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
