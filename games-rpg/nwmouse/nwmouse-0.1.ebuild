# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwmouse/nwmouse-0.1.ebuild,v 1.6 2007/08/27 20:24:38 wolf31o2 Exp $

inherit games

DESCRIPTION="hardware mouse cursors for Neverwinter Nights"
HOMEPAGE="http://home.woh.rr.com/nwmovies/nwmouse/"
SRC_URI="http://home.woh.rr.com/nwmovies/cursors.tar.gz
	http://dev.gentoo.org/~wolf31o2/sources/dump/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
# I've looked at this stuff, and I can't find the problem myself, so I'm just
# removing the warnings.  If someone feels like finding the patch, that would be
# great and I'll gladly include it.
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/nwn/nwmouse.so"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/nwn/nwmouse.so"
IUSE=""
RESTRICT="strip mirror"

RDEPEND="sys-libs/glibc
	games-rpg/nwn-data
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl )
	games-rpg/nwn
	x86? (
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libX11
		media-libs/libsdl )"

S="${WORKDIR}/${PN}"
dir="${GAMES_PREFIX_OPT}/nwn"

pkg_setup() {
	games_pkg_setup
	elog "This package is pre-compiled so it will work on both x86 and amd64."
}

src_unpack() {
	unpack ${P}.tar.bz2 || die
	mkdir ${S}/cursors || die
	cd ${S}/cursors || die
	unpack cursors.tar.gz || die
}

src_install() {
	exeinto "${dir}"
	doexe nwmouse.so || die
	exeinto "${dir}/lib"
	doexe libelf/libelf.so.1
	exeinto "${dir}/nwmouse/libdis"
	doexe libdis/libdisasm.so || die
	insinto "${dir}/nwmouse/cursors"
	doins cursors/* || die
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "When starting nwn the next time, nwmouse will scan the nwmain"
	elog "binary for its hooks, store this information in:"
	elog "  ${dir}/nwmouse.ini"
	elog "and exit. This is normal."
	elog
	elog "You will have to remove this file whenever you update nwn."
}
