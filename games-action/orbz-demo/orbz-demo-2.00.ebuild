# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/orbz-demo/orbz-demo-2.00.ebuild,v 1.2 2004/02/20 06:13:57 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="action/arcade game set in colorful 3D environments"
HOMEPAGE="http://www.21-6.com/orbz.asp"
SRC_URI="ftp://ftp5.homelan.com/public/21-6/orbz_demo_${PV/./_}.sh.bin"

LICENSE="ORBZ"
SLOT="0"
KEYWORDS="-* x86"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	tar -zxf Orbz.tar.gz -C ${D}/${dir} || die "extracting orbz.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/*
	dosym ${dir}/orbzdemo ${GAMES_BINDIR}/orbzdemo
	dosym ${dir}/orbzdemodedicated ${GAMES_BINDIR}/orbzdemodedicated

	insinto ${dir}
	doins icon.xpm

	dodoc README.txt

	prepgamesdirs
}
