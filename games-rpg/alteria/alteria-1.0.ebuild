# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/alteria/alteria-1.0.ebuild,v 1.1 2003/12/29 03:48:15 vapier Exp $

inherit games eutils flag-o-matic

DESCRIPTION="a world that is ruled by a constant struggle between human and orc"
HOMEPAGE="http://www.planetquake.com/cor/omen/"
SRC_URI="alteria-${PV}-x86.run
	${P}.src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"

DEPEND=""
#RDEPEND=""

S=${WORKDIR}/alteria/WinQuake

pkg_nofetch() {
	einfo "Please download ${A} here:"
	einfo "http://dl.fileplanet.com/dl/dl.asp?cor/alteria-1.0-x86.run"
	einfo "http://icculus.org/~ravage/alteria/alteria-1.0.src.tar.gz"
	einfo "Then put the file in ${DISTDIR}"
}

src_unpack() {
	unpack ${P}.src.tar.gz
	mkdir data
	cd data
	unpack_makeself alteria-${PV}-x86.run
	tar -jxf data.tar.bz2 -C ..
	rm -rf ../data
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-cflags.patch
	sed -i "s:GENTOO_CFLAGS:${CFLAGS}:" Makefile
	epatch ${FILESDIR}/${PV}-systemdir.patch
	sed -i "s:GENTOO_DATADIR:\"${GAMES_DATADIR}/${PN}\":" common.c
}

src_compile() {
	emake build_release || die "compile failed"
}

src_install() {
	newgamesbin release*/bin/alteria.glx alteria
	dodir ${GAMES_DATADIR}/${PN}/data1/
	cp ${WORKDIR}/data1/* ${D}/${GAMES_DATADIR}/${PN}/data1/
	prepgamesdirs
}
