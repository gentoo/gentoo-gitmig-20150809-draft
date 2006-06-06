# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-demo/doom3-demo-1.1.1286.ebuild,v 1.15 2006/06/06 18:45:47 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Doom III - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="mirror://3dgamers/doom3/doom3-linux-${PV}-demo.x86.run
	mirror://idsoftware/doom3/linux/doom3-linux-${PV}-demo.x86.run
	mirror://gentoo/doom3.png"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="opengl dedicated"
RESTRICT="strip mirror"

DEPEND="app-arch/bzip2
	app-arch/tar"

# Do not remove the amd64 dep unless you are POSITIVE that it is not necessary.
# See bug #88227 for more.
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		|| ( >=app-emulation/emul-linux-x86-xlibs-7.0
			>=media-video/nvidia-glx-1.0.6629-r3
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

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

	newicon ${DISTDIR}/doom3.png doom3-demo.png

	games_make_wrapper doom3-demo ./doom.x86 "${dir}" "${dir}"
	make_desktop_entry doom3-demo "Doom III (Demo)" doom3-demo.png

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "To play the game run:"
	einfo " doom3-demo"
}
