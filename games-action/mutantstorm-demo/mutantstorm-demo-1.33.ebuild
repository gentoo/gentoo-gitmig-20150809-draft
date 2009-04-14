# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/mutantstorm-demo/mutantstorm-demo-1.33.ebuild,v 1.11 2009/04/14 07:24:59 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="shoot through crazy psychedelic 3D environments"
HOMEPAGE="http://www.pompomgames.com/"
SRC_URI="ftp://ggdev-1.homelan.com/mutantstorm/MutantStormDemo_${PV/./_}.sh.bin"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"

RDEPEND="virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )
	x86? (
		x11-libs/libX11
		x11-libs/libXext )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	insinto "${dir}"
	doins -r menu script styles || die "doins failed"

	exeinto "${dir}"
	doexe bin/Linux/x86/* || die "doexe failed"
	# Remove libSDL since we use the system version and our version doesn't
	# have TEXTRELs in it.
	rm -f "${Ddir}"/libSDL-1.2.so.0.0.5
	games_make_wrapper mutantstorm-demo ./mutantstormdemo "${dir}" "${dir}"

	insinto "${dir}"
	doins README.txt buy_me mutant.xpm pompom readme.htm || die "doins failed"

	prepgamesdirs
}
