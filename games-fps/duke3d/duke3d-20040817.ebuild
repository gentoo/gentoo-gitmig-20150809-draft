# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/duke3d/duke3d-20040817.ebuild,v 1.4 2004/12/05 12:15:59 mr_bones_ Exp $

fromcvs=0
ECVS_MODULE="duke3d"
if [ ${fromcvs} -eq 1 ] ; then
	ECVS_PASS="anonymous"
	ECVS_SERVER="icculus.org:/cvs/cvsroot"
	inherit cvs eutils flag-o-matic games
else
	inherit eutils flag-o-matic games
fi

DESCRIPTION="port of the original DukeNukem 3D"
HOMEPAGE="http://icculus.org/projects/duke3d/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="perl opengl" # nophysfs"

RDEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer
	media-sound/timidity++
	media-sound/timidity-eawpatches
	perl? ( dev-lang/perl )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	>=sys-apps/sed-4"

S="${WORKDIR}/${ECVS_MODULE}"

use_tf() { useq ${1} && echo "true" || echo "false"; }

src_unpack() {
	if [ ${fromcvs} -eq 1 ] ; then
		cvs_src_unpack
		cd duke3d/source
		ECVS_MODULE="buildengine"
		cvs_src_unpack
	else
		unpack ${A}
	fi

	# configure buildengine
	cd "${S}/source/buildengine"
	sed -i \
		-e "/^useperl := / s:=.*:= $(use_tf perl):" \
		-e "/^useopengl := / s:=.*:= $(use_tf opengl):" \
		-e "/^usephysfs := / s:=.*:= false:" \
		-e 's:-O3::' -e 's: -g : :' \
		-e 's:/usr/lib/perl5/i386-linux/CORE/libperl.a::' \
		Makefile \
		|| die "sed build Makefile failed"
	epatch "${FILESDIR}/${PV}-endian.patch"

	# configure duke3d
	cd "${S}/source"
	epatch "${FILESDIR}/${PV}-credits.patch"
	# need to sync features with build engine
	epatch "${FILESDIR}/${PV}-duke3d-makefile-opts.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch" # compile fixes for GCC 3.4
	sed -i \
		-e "/^use_opengl := / s:=.*:= $(use_tf opengl):" \
		-e "/^use_physfs := / s:=.*:= false:" \
		Makefile \
		|| die "sed duke3d Makefile failed"
	if use x86 ; then
		sed -i \
			-e 's:^#USE_ASM:USE_ASM:' buildengine/Makefile \
			|| die "sed failed"
		sed -i \
			-e '/^#use_asm := /s:#::' Makefile \
			|| die "sed failed"
	fi

	# causes crazy redefine errors with gcc-3.[2-4].x
	replace-flags -O3 -O2
}

src_compile() {
	cd source/buildengine
	emake OPTFLAGS="${CFLAGS}" || die "buildengine failed"
	cd ..
	emake OPTIMIZE="${CFLAGS}" || die "duke3d failed"
}

src_install() {
	games_make_wrapper duke3d "${GAMES_BINDIR}/duke3d.bin" "${GAMES_DATADIR}/${PN}"
	newgamesbin source/duke3d duke3d.bin || die "newgamesbin failed"

	dodoc readme.txt

	cd testdata
	insinto "${GAMES_DATADIR}/${PN}"
	newins defs.con DEFS.CON
	newins game.con GAME.CON
	newins user.con USER.CON
	doins "${FILESDIR}/network.cfg"
	insinto "${GAMES_SYSCONFDIR}"
	doins "${FILESDIR}/duke3d.cfg"
	dosym "${GAMES_SYSCONFDIR}/duke3d.cfg" "${GAMES_DATADIR}/${PN}/DUKE3D.CFG"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Just put the data files in ${GAMES_DATADIR}/${PN}"
	einfo "before playing !"
}
