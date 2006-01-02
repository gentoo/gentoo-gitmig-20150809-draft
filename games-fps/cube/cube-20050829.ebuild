# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/cube/cube-20050829.ebuild,v 1.5 2006/01/02 17:02:27 hansmi Exp $

inherit eutils flag-o-matic games

MY_PV=${PV:0:4}_${PV:4:2}_${PV:6:2}
MY_P=${PN}_${MY_PV}
DESCRIPTION="Landscape-style engine that pretends to be an indoor first person shooter engine"
HOMEPAGE="http://www.cubeengine.com/"
SRC_URI="mirror://sourceforge/cube/${MY_P}_unix.tar.gz
	mirror://sourceforge/cube/${MY_P}_src.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc x86"
IUSE="dedicated"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/cube_source
S_BIN=${WORKDIR}/cube
CUBE_DATADIR=${GAMES_DATADIR}/${PN}/

src_unpack() {
	unpack ${A}

	cd "${S}"/src
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	echo "#define GAMES_DATADIR \"${CUBE_DATADIR}\"" >> tools.h
	echo "#define GAMES_DATADIR_LEN ${#CUBE_DATADIR}" >> tools.h
	sed -i \
		-e "s:packages/:${CUBE_DATADIR}packages/:" \
		renderextras.cpp rendermd2.cpp sound.cpp worldio.cpp \
		|| die "fixing data path failed"
	# enable parallel make
	sed -i \
		-e 's/make -C/$(MAKE) -C/' \
		Makefile \
		|| die "sed Makefile failed"
	edos2unix *.cpp
	chmod a+x "${S}"/enet/configure
}

src_compile() {
	append-flags -fsigned-char
	cd enet
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
	cd ../src
	einfo "Compiling in $(pwd)"
	emake CXXOPTFLAGS="-DHAS_SOCKLEN_T=1 -fpermissive ${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin src/cube_client || die "dogamesbin client failed"
	if use dedicated ; then
		dogamesbin src/cube_server "${S_BIN}"/bin_unix/linux_server \
			|| die "dogamesbin server failed"
	fi
	dodoc src/CUBE_TODO.txt

	cd "${S_BIN}"
	insinto "${CUBE_DATADIR}"
	doins -r *.cfg data packages || die "doins failed"
	dohtml -r docs readme.html

	if [[ ${ARCH} == "x86" ]] ; then
		exeinto "${GAMES_LIBDIR}"/${PN}
		newexe bin_unix/linux_client cube_client || die "newexe server failed"
		games_make_wrapper cube_client-bin \
			"${GAMES_LIBDIR}"/${PN}/cube_client "${GAMES_DATADIR}"/${PN} \
			|| die "games_make_wrapper client failed"
		make_desktop_entry cube_client-bin "Cube Client"
	else
		make_desktop_entry cube_client "Cube Client"
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if [[ ${ARCH} == "x86" ]] ; then
		einfo "You now have 2 clients and 2 servers:"
		einfo "cube_client-bin      prebuilt version (needed to play on public multiplayer servers)"
	else
		einfo "You only have 1 client and 1 server:"
	fi
	einfo "cube_client          custom client built from source"
	use dedicated && \
	einfo "Parallel versions of the server have been installed"
}
