# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxracer-demo/tuxracer-demo-1.1.ebuild,v 1.11 2006/12/01 20:31:57 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="race downhill as different arctic characters (including Tux!)"
HOMEPAGE="http://www.tuxracer.com/"
SRC_URI="tuxracer-demo-${PV}-linux-i386.sh"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch strip"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	x11-libs/libXi
	x11-libs/libXmu"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://www.tuxracer.com/?page=downloads.php"
	einfo "and download ${A}"
	einfo "and put the files in ${DISTDIR}"
}

src_unpack() {
	unpack_makeself tuxracer-demo-${PV}-linux-i386.sh
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	exeinto ${dir}
	doexe bin/x86/glibc-2.1/*
	insinto ${dir}
	doins EULA GPL LGPL README Tcl_license language *.tcl
	cp -r characters courses fonts models music tcllib textures ${D}/${dir}

	dodir ${GAMES_BINDIR}
	dosym ${dir}/tuxracer-demo ${GAMES_BINDIR}/tuxracer-demo

	prepgamesdirs
}
