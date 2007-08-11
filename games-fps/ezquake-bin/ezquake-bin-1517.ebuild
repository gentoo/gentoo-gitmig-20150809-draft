# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ezquake-bin/ezquake-bin-1517.ebuild,v 1.6 2007/08/11 07:36:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Quakeworld client under active development, forked from fuhquake, including long-wanted mqwcl functionality and many more features."
HOMEPAGE="http://ezquake.sf.net/"
SRC_URI="http://wit.edu.pl/~rzadzinp/ezquake/releases/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="strip"
IUSE="opengl svga cdinstall"

QA_EXECSTACK_x86="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"
QA_EXECSTACK_amd64="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"

RDEPEND=">=dev-libs/expat-2.0
	=dev-libs/glib-1.2*
	!svga? ( x11-libs/libXext )
	svga? ( media-libs/svgalib )
	opengl? ( virtual/opengl x11-libs/libXext )
	cdinstall? ( games-fps/quake1-data )"

S=${WORKDIR}/${PN}

dir=${GAMES_PREFIX_OPT}/${PN}

src_install() {
	exeinto "${dir}"
	insinto "${dir}"
	BINS="ezquake-gl.glx ezquake.x11 ezquake.svga"
	doexe ${BINS} ezquake-security.so || die "doexe"
	doins -r ezquake qw || die "cp dirs"
	dodir "${GAMES_DATADIR}"/quake1/id1
	dosym "${GAMES_DATADIR}"/quake1/id1 "${dir}"/id1

	for x in ${BINS}; do
		games_make_wrapper ${x} ./${x} "${dir}" "${dir}"
	done
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE that this client doesnt include .pak files. You need to copy them from"
	elog "your quake1 CD (see also: http://www.idsoftware.com/store/index.php?view=quake&page=2), "
	elog "(note that quake1 shareware packs are free) and put them in"
	elog "  ${GAMES_PREFIX_OPT}/quake1/id1 (all names lowercase)"
	elog "You may also want to check:"
	elog "--> http://fuhquake.quakeworld.nu  -- complete howto on commands and variables"
	elog "--> http://equake.quakeworld.nu -- free package containing various files"
}
