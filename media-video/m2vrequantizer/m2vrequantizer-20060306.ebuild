# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/m2vrequantizer/m2vrequantizer-20060306.ebuild,v 1.4 2007/07/12 02:40:43 mr_bones_ Exp $

MY_P="${PN/m2vr/M2VR}-${PV}"

DESCRIPTION="Tool to requantize mpeg2 videos"
HOMEPAGE="http://www.metakine.com/products/dvdremaster/modules.html"
SRC_URI="mirror://vdrfiles/requant/${MY_P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="!media-video/requant"

S=${WORKDIR}/M2VRequantiser

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i "s:#elif defined(__i386__):#elif defined(__i386__) || defined(__amd64__):" main.c
}

src_compile() {

	gcc -c ${CFLAGS} main.c -o requant.o
	gcc ${CFLAGS} requant.o -o requant -lm
}

src_install() {

	dobin requant
}
