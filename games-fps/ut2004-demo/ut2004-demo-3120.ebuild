# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-demo/ut2004-demo-3120.ebuild,v 1.1 2004/02/14 02:44:41 vapier Exp $

inherit games eutils

DESCRIPTION="Unreal Tournament 2004 Demo"
HOMEPAGE="http://www.unrealtournament.com/"
SRC_URI="ftp://ftp.linuxhardware.org/ut2004/ut2004-lnx-demo-${PV}.run.bz2
	http://www.lokigames.com/sekrit/ut2004-lnx-demo-${PV}.run.bz2
	http://pomac.netswarm.net/mirror/games/ut2004/ut2004-lnx-demo-${PV}.run.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

DEPEND="virtual/opengl"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack_makeself ut2004-lnx-demo-${PV}.run
	rm ut2004-lnx-demo-${PV}.run
}

src_install() {
	local dir=/opt/${PN}
	dodir ${dir}

	tar -xf ut2004demo.tar -C ${D}/${dir}/ || die "unpacking ut2004 failed"

	insinto ${dir}
	doins README.linux ut2004demo.xpm

	exeinto ${dir}
	doexe bin/ut2004demo

	dodir ${GAMES_BINDIR}
	dosym ${dir}/ut2004demo ${GAMES_BINDIR}/ut2004demo

	prepgamesdirs
}
