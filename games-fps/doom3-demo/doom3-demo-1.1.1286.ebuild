# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-demo/doom3-demo-1.1.1286.ebuild,v 1.2 2005/04/07 20:03:04 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Doom III - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/doom3/linux/doom3-linux-${PV}-demo.x86.run
	ftp://dl.xs4all.nl/pub/mirror/idsoftware/idstuff/doom3/linux/doom3-linux-${PV}-demo.x86.run
	mirror://gentoo/doom3.png"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="opengl dedicated"
RESTRICT="nostrip nomirror"

DEPEND="app-arch/bzip2
	app-arch/tar"

# Do not remove the amd64 dep unless you are POSITIVE that it is not necessary.
# See bug #88227 for more.
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself doom3-linux-${PV}-demo.x86.run
}

src_install() {
	dodir ${dir}

	insinto ${dir}
	doins License.txt README version.info
	exeinto ${dir}
	doexe gamex86.so libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	if use amd64; then
		doexe bin/Linux/amd64/doom.x86 || die "doexe doom.x86"
	elif use x86; then
		doexe bin/Linux/x86/doom.x86 || die "doexe doom"
	else
		die "Platform not supported"
	fi

	insinto ${dir}/demo
	doins demo/* || die "doins base"

	games_make_wrapper doom3-demo ./doom.x86 ${dir}

	insinto /usr/share/pixmaps
	newins ${DISTDIR}/doom3.png doom3-demo.png

	prepgamesdirs
	make_desktop_entry doom3-demo "Doom III Demo" doom3-demo.png
}

pkg_postinst() {
	games_pkg_postinst

	einfo "To play the game run:"
	einfo " doom3-demo"
}
