# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/cube/cube-20031223.ebuild,v 1.3 2004/02/20 06:40:07 mr_bones_ Exp $

inherit eutils games

MY_P="cube_2003_12_23"
DESCRIPTION="Landscape-style engine that pretends to be an indoor first person shooter engine"
HOMEPAGE="http://wouter.fov120.com/cube/"
SRC_URI="mirror://sourceforge/cube/${MY_P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc hppa"

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"

S=${WORKDIR}/cube
CUBE_DATADIR=${GAMES_DATADIR}/${PN}/

src_unpack() {
	unpack ${A}

	cd ${S}/source
	unzip -qn ${MY_P}_src.zip || die

	cd ${MY_P}_src/src
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch || die
	echo "#define GAMES_DATADIR \"${CUBE_DATADIR}\"" >> tools.h
	echo "#define GAMES_DATADIR_LEN ${#CUBE_DATADIR}" >> tools.h
	sed -i \
		"s:packages/:${CUBE_DATADIR}packages/:" \
		renderextras.cpp rendermd2.cpp sound.cpp worldio.cpp \
		|| die "fixing data path failed"
	edos2unix *.cpp
}

src_compile() {
	cd source/${MY_P}_src/src
	emake CXXOPTFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dogamesbin source/${MY_P}_src/src/cube_{client,server}
	exeinto ${GAMES_LIBDIR}/${PN}
	if [ "${ARCH}" == "x86" ] ; then
		newexe bin_unix/linux_client cube_client
		newexe bin_unix/linux_server cube_server
	elif [ "${ARCH}" == "ppc" ] ; then
		newexe bin_unix/ppc_linux_client cube_client
		newexe bin_unix/ppc_linux_server cube_server
	fi
	dogamesbin ${FILESDIR}/cube_{client,server}-bin
	sed -i \
		-e "s:GENTOO_DATADIR:${CUBE_DATADIR}:" \
		-e "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" \
		${D}/${GAMES_BINDIR}/cube_{client,server}-bin

	dodir ${CUBE_DATADIR}
	cp -r *.cfg data packages ${D}/${CUBE_DATADIR}

	dodoc source/${MY_P}_src/src/CUBE_TODO.txt
	dohtml -r docs/
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "You now have 2 clients and 2 servers:"
	einfo "cube_client-bin      prebuilt version (needed to play on public multiplayer servers)"
	einfo "cube_client          custom client built from source"
	einfo "Parallel versions of the server have been installed"
}
