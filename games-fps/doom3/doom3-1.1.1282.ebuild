# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.1.1282.ebuild,v 1.1 2004/10/05 04:29:01 vapier Exp $

inherit games eutils

DESCRIPTION="DOOM 3"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/doom3/linux/doom3-linux-${PV}.x86.run
	mirror://gentoo/doom3-linux-${PV}.x86.run"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="sys-libs/glibc
	virtual/x11"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto ${dir}
	doins License.txt README version.info
	exeinto ${dir}
	doexe libgcc_s.so.1 libstdc++.so.5 || die "doexe libs"
	doexe bin/Linux/x86/glibc-2.1/doom{,ded}.x86 || die "doexe exes"

	insinto ${dir}/base
	doins base/* || die "doins base"

	dogamesbin ${FILESDIR}/doom3
	dosed "s:DIR:${dir}:" ${GAMES_BINDIR}/doom3
	dosed "s:EXE:doom.x86:" ${GAMES_BINDIR}/doom3
	games_make_wrapper doom3-dedicated ./doomded.x86 "${dir}" .

	prepgamesdirs
}
