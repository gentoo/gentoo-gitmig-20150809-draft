# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/duke3d/duke3d-20030817-r1.ebuild,v 1.10 2004/03/19 16:51:35 vapier Exp $

ECVS_PASS="anonymous"
ECVS_SERVER="icculus.org:/cvs/cvsroot"
ECVS_MODULE="duke3d"
inherit eutils flag-o-matic games
#inherit cvs

DESCRIPTION="port of the original DukeNukem 3D"
HOMEPAGE="http://icculus.org/projects/duke3d/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="perl opengl" # nophysfs"

DEPEND="virtual/x11
	x86? ( dev-lang/nasm )
	>=sys-apps/sed-4
	media-libs/libsdl
	media-libs/sdl-mixer
	media-sound/timidity++
	media-sound/timidity-eawpatches
	opengl? ( virtual/opengl )"
#	!nophysfs? ( dev-games/physfs )"

S="${WORKDIR}/${ECVS_MODULE}"

use_tf() { [ `use ${1}` ] && echo true || echo false; }
use_ft() { [ `use ${1}` ] && echo false || echo true; }

src_unpack() {
	local fromcvs=0
	if [ ${fromcvs} -eq 1 ] ; then
		cvs_src_unpack
		cd duke3d/source
		ECVS_MODULE="buildengine"
		cvs_src_unpack
	else
		unpack ${A}
	fi

	# configure buildengine
	cd ${S}/source/buildengine
#		-e "/^usephysfs := /s:=.*:= `use_ft nophysfs`:" \
	sed -i \
		-e "/^useperl := /s:=.*:= `use_tf perl`:" \
		-e "/^useopengl := /s:=.*:= `use_tf opengl`:" \
		-e "/^usephysfs := /s:=.*:= false:" \
		Makefile
	[ `use x86` ] && sed -i 's:^#USE_ASM:USE_ASM:' Makefile
	epatch ${FILESDIR}/${PV}-buildengine-makefile-cflags.patch
	sed -i 's:/usr/lib/perl5/i386-linux/CORE/libperl.a::' Makefile

	# configure duke3d
	cd ${S}/source
	epatch ${FILESDIR}/${PV}-duke3d-makefile-opts.patch
	[ `use x86` ] && sed -i '/^#use_asm/s:#::' Makefile
	[ `use opengl` ] && sed -i '/^#use_opengl/s:#::' Makefile
#	[ `use nophysfs` ] || sed -i '/^#use_physfs/s:#::' Makefile
}

src_compile() {
	# -O3 fails on athlon with gcc 3.2.3, maybe others.
	replace-flags "-O3" "-O2"
	cd source/buildengine
	emake OPTFLAGS="${CFLAGS}" || die "buildengine failed"
	cd ..
	emake OPTIMIZE="${CFLAGS}" || die "duke3d failed"
}

src_install() {
	dogamesbin ${FILESDIR}/duke3d
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/duke3d
	newgamesbin source/duke3d duke3d.bin

	dodoc readme.txt

	cd testdata
	insinto ${GAMES_DATADIR}/${PN}
	newins defs.con DEFS.CON
	newins game.con GAME.CON
	newins user.con USER.CON
	doins ${FILESDIR}/network.cfg
	insinto ${GAMES_SYSCONFDIR}
	doins ${FILESDIR}/duke3d.cfg
	dosym ${GAMES_SYSCONFDIR}/duke3d.cfg ${GAMES_DATADIR}/${PN}/DUKE3D.CFG

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Just put the data files in ${GAMES_DATADIR}/${PN}"
	einfo "before playing !"
}
