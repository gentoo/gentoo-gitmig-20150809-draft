# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/cube/cube-20040522.ebuild,v 1.6 2004/11/11 21:02:44 blubb Exp $

inherit eutils games

MY_PV="2004_05_22"
MY_P=${PN}_${MY_PV}
DESCRIPTION="Landscape-style engine that pretends to be an indoor first person shooter engine"
HOMEPAGE="http://wouter.fov120.com/cube/"
SRC_URI="mirror://sourceforge/cube/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="hppa ppc x86 ~amd64"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/sed-4"

S="${WORKDIR}/cube"
CUBE_DATADIR="${GAMES_DATADIR}/${PN}/"

src_unpack() {
	unpack ${A}

	cd ${S}/source
	unzip -qn ${MY_P}_src.zip || die
	epatch ${FILESDIR}/${PV}-compile-fixes.patch

	cd src
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
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
	chmod a+x ${S}/source/enet/configure
}

src_compile() {
	cd source/enet
	econf || die
	emake || die "emake failed"
	cd ../src
	einfo "Compiling in $(pwd)"
	emake CXXOPTFLAGS="-DHAS_SOCKLEN_T=1 -fpermissive ${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin source/src/cube_{client,server} || die "dogamesbin failed"
	exeinto "${GAMES_LIBDIR}/${PN}"
	if [ "${ARCH}" == "x86" ] ; then
		newexe bin_unix/linux_client cube_client || die "newexe failed"
		newexe bin_unix/linux_server cube_server || die "newexe failed"
	elif [ "${ARCH}" == "ppc" ] ; then
		newexe bin_unix/ppc_linux_client cube_client || die "newexe failed"
		newexe bin_unix/ppc_linux_server cube_server || die "newexe failed"
	fi
	dogamesbin "${FILESDIR}/cube_"{client,server}-bin \
		|| die "dogamesbin failed (bin)"
	sed -i \
		-e "s:GENTOO_DATADIR:${CUBE_DATADIR}:" \
		-e "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" \
		"${D}/${GAMES_BINDIR}/cube_"{client,server}-bin \
		|| die "sed failed"

	dodir "${CUBE_DATADIR}"
	cp -r *.cfg data packages "${D}/${CUBE_DATADIR}" \
		|| die "cp failed"

	dodoc source/src/CUBE_TODO.txt
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
