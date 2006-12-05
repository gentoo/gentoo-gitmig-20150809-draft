# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1/quake1-2.40-r1.ebuild,v 1.8 2006/12/05 17:18:42 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="The original Quake engine straight from id !"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake/"
SRC_URI="mirror://idsoftware/source/q1source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="cdinstall X opengl svga 3dfx"

RDEPEND="X? ( x11-libs/libX11 )
	opengl? ( virtual/opengl )
	svga? ( media-libs/svgalib )
	3dfx? ( media-libs/glide-v3 )"
DEPEND="${RDEPEND}
	cdinstall? ( games-fps/quake1-data )
	app-arch/unzip"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	echo
	ewarn "You probably want games-fps/quakeforge if you're"
	ewarn "looking for a quake1 client ..."
	ebeep
	epause
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/fix-sys_printf.patch

	mv WinQuake/Makefile{.linuxi386,}
	mv QW/Makefile{.Linux,}

	epatch "${FILESDIR}"/makefile-path-fixes.patch
	epatch "${FILESDIR}"/gentoo-paths.patch
	sed -i -e "s:GENTOO_DATADIR:${GAMES_DATADIR}/quake1:" \
		{QW/client,WinQuake}/common.c || die "setting data paths"

	epatch "${FILESDIR}"/makefile-cflags.patch
	sed -i "s:GENTOO_CFLAGS:${CFLAGS} -DGL_EXT_SHARED=1:" {WinQuake,QW}/Makefile

	cp QW/client/glquake.h{,.orig}
	(echo "#define APIENTRY";cat QW/client/glquake.h.orig) > QW/client/glquake.h

	epatch "${FILESDIR}"/makefile-sedable.patch
	if ! use 3dfx ; then
		sed -i 's:^   $(BUILDDIR)/bin/glquake ::' WinQuake/Makefile
		sed -i 's:^   $(BUILDDIR)/bin/glquake.3dfxgl ::' WinQuake/Makefile
		sed -i 's:^   $(BUILDDIR)/glqwcl ::' QW/Makefile
	fi
	if ! use X ; then
		sed -i 's:^   $(BUILDDIR)/bin/quake.x11 ::' WinQuake/Makefile
		sed -i 's:^   $(BUILDDIR)/qwcl.x11 ::' QW/Makefile
	fi
	if ! use opengl ; then
		sed -i 's:^   $(BUILDDIR)/bin/quake.glx ::' WinQuake/Makefile
		sed -i 's:^   $(BUILDDIR)/glqwcl.glx ::' QW/Makefile
	fi
	if ! use svga ; then
		sed -i 's:^   $(BUILDDIR)/bin/squake ::' WinQuake/Makefile
		sed -i 's:^   $(BUILDDIR)/qwcl ::' QW/Makefile
	fi
}

src_compile() {
	emake -j1 -C "${S}"/WinQuake build_release || die "failed to build WinQuake"
	emake -j1 -C "${S}"/QW build_release || die "failed to build QW"
}

src_install() {
	dogamesbin WinQuake/release*/bin/* QW/release*/*qw* || die "dogamesbin failed"
	dodoc readme.txt {WinQuake,QW}/*.txt
	prepgamesdirs
}

pkg_postinst() {
	# same warning used in quake1 / quakeforge / nprquake-sdl
	games_pkg_postinst
	echo
	einfo "Before you can play, you must make sure"
	einfo "${PN} can find your Quake .pak files"
	echo
	einfo "You have 2 choices to do this"
	einfo "1 Copy pak*.pak files to ${GAMES_DATADIR}/quake1/id1"
	einfo "2 Symlink pak*.pak files in ${GAMES_DATADIR}/quake1/id1"
	echo
	einfo "Example:"
	einfo "my pak*.pak files are in /mnt/secondary/Games/Quake/Id1/"
	einfo "ln -s /mnt/secondary/Games/Quake/Id1/pak0.pak ${GAMES_DATADIR}/quake1/id1/pak0.pak"
	echo
	einfo "You only need pak0.pak to play the demo version,"
	einfo "the others are needed for registered version"
}
