# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/cube/cube-20021020-r2.ebuild,v 1.2 2004/02/20 06:40:07 mr_bones_ Exp $

inherit eutils games

MY_P="cube_2002_10_20"
DESCRIPTION="Landscape-style engine that pretends to be an indoor first person shooter engine"
HOMEPAGE="http://wouter.fov120.com/cube/"
SRC_URI="http://ludo.uib.no/cube/${MY_P}.zip
	http://www.idi.ntnu.no/~jonasf/cube/${MY_P}.zip
	http://tunes.org/~eihrul/${MY_P}.zip
	http://tunes.org/~eihrul/enet_2002_10_28.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"

S=${WORKDIR}
CUBE_DATADIR=${GAMES_DATADIR}/${PN}/

src_unpack() {
	unpack ${A}

	cd source
	unzip -qn ${MY_P}_src.zip || die

	# enet_2002_10_28.tar.gz patch
	rm -rf enet
	mv ../enet .

	cd src
	epatch ${FILESDIR}/${P}-add-custom-paths.patch || die
	echo "#define GAMES_DATADIR \"${CUBE_DATADIR}\"" >> tools.h
	echo "#define GAMES_DATADIR_LEN ${#CUBE_DATADIR}" >> tools.h
	for f in sound worldio ; do
		f="${f}.cpp"
		cp ${f} ${f}.old
		sed -e "s:packages/:${CUBE_DATADIR}packages/:" ${f}.old > ${f}
	done
	edos2unix *.cpp
}

src_compile() {
	cd source/src
	make || die
}

src_install() {
	dogamesbin source/src/cube_{client,server}
	if [ "${ARCH}" == "x86" ] ; then
		newgamesbin bin_unix/linux_client cube_client-bin
		newgamesbin bin_unix/linux_server cube_server-bin
	elif [ "${ARCH}" == "ppc" ] ; then
		newgamesbin bin_unix/ppc_linux_client cube_client-bin
		newgamesbin bin_unix/ppc_linux_server cube_server-bin
	fi
	echo "#!/bin/bash"$'\n'"cd ${CUBE_DATADIR}"$'\n'"cube_client-bin $@" > ${T}/client
	echo "#!/bin/bash"$'\n'"cd ${CUBE_DATADIR}"$'\n'"cube_server-bin $@" > ${T}/server
	newgamesbin ${T}/client playcubeclient
	newgamesbin ${T}/server playcubeserver

	dodir ${CUBE_DATADIR}
	mv *.cfg data packages ${D}/${CUBE_DATADIR}

	dodoc source/src/CUBE_TODO.txt
	dohtml -r docs/

	prepgamesdirs
}

pkg_postinst() {
	einfo "You now have 3 clients and 3 servers:"
	einfo "cube_client-bin      prebuilt version (needed to play on public multiplayer servers)"
	einfo "playcubeclient       wrapper to setup path's for the prebuilt binary"
	einfo "cube_client          custom client built from source"
	einfo "Parallel versions of the server have been installed"
	games_pkg_postinst
}
