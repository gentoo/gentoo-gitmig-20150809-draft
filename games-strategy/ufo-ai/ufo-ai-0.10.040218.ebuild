# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-0.10.040218.ebuild,v 1.2 2004/03/11 12:14:23 wolf31o2 Exp $

inherit games

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
SRC_URI="http://n.ethz.ch/student/dbeyeler/download/ufoai_source_040218.zip
	     http://people.ee.ethz.ch/~baepeter/linux_ufoaidemo.zip"
HOMEPAGE="http://ufo.myexp.de/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc
	    virtual/x11
		media-libs/jpeg
		media-libs/libvorbis
		media-libs/libogg"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}/source/linux || die "change dir"
	epatch ${FILESDIR}/${PV}-Makefile.patch || die "patching"
}

src_compile() {
	cd ${S}/source/linux || die "change dir"
	make build_release \
		 OPTCFLAGS="${CFLAGS}" \
		 || die "make failed"
}

src_install() {
	dodir ${GAMES_DATADIR}/${PN}
	cp -rf ${S}/ufo/* ${D}${GAMES_DATADIR}/${PN} || die "copy data"
	cd ${S}/source/linux/releasei386-glibc || die "change dir"
	exeinto ${GAMES_DATADIR}/${PN}
	doexe ${S}/source/linux/releasei386-glibc/{ref_gl.so,ref_glx.so,ufo} \
		|| die "doexe ufo"
	exeinto ${GAMES_DATADIR}/${PN}/base
	doexe ${S}/source/linux/releasei386-glibc/gamei386.so \
		|| die "doexe gamei386.so"
	games_make_wrapper ufo-ai ./ufo ${GAMES_DATADIR}/${PN}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
