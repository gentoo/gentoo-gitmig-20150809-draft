# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxracer-demo/tuxracer-demo-1.1.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="race downhill as different artic characters (including Tux!)"
HOMEPAGE="http://www.tuxracer.com/"
SRC_URI="tuxracer-demo-${PV}-linux-i386.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="nofetch"

DEPEND="virtual/opengl
	virtual/glu
	virtual/x11"

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
