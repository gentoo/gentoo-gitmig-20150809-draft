# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-demo/doom3-demo-1.1.1282.ebuild,v 1.2 2004/10/07 14:10:05 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="Doom III - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/doom3/linux/doom3-linux-${PV}-demo.x86.run"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="opengl dedicated"
RESTRICT="nostrip nomirror"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-nvidia	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}

	insinto ${dir}
	doins License.txt README version.info
	exeinto ${dir}
	doexe gamex86.so libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	doexe bin/Linux/x86/glibc-2.1/doom.x86 || die "doexe doom"

	insinto ${dir}/demo
	doins demo/* || die "doins base"

	games_make_wrapper doom3-demo ./doom.x86 ${dir}

	prepgamesdirs
	make_desktop_entry doom3-demo "Doom III Demo" doom3.xpm
}

pkg_postinst() {
	games_pkg_postinst

	einfo "To play the game run:"
	einfo " doom3-demo"

	# IA32 Emulation required for amd64
	if use amd64 ; then
		echo
		ewarn "NOTE: IA32 Emulation must be compiled into your kernel for Doom3 to run."
	fi
}
