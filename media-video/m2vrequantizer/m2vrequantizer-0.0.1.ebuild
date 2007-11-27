# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/m2vrequantizer/m2vrequantizer-0.0.1.ebuild,v 1.3 2007/11/27 11:55:55 zzam Exp $

REQUANT="M2VRequantizer"
REQUANT_VN="20030925"
JAU_FILE="repackmpeg2-v0.9"

DESCRIPTION="Tool to requantize/shrink mpeg2 videos"
HOMEPAGE="http://www.jausoft.com"
SRC_URI="mirror://vdrfiles/requant/${JAU_FILE}.tar.bz2"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

S=${WORKDIR}/${JAU_FILE}

src_unpack() {
	unpack ${A}
	tar xjf "${S}"/${REQUANT}-${REQUANT_VN}.tar.bz2
}

src_compile() {

	cd "${WORKDIR}/${REQUANT}-${REQUANT_VN}/src"
	gcc -c ${CFLAGS} main.c -o requant.o
	gcc ${CFLAGS} requant.o -o requant -lm
}

src_install() {

	dobin "${WORKDIR}/${REQUANT}-${REQUANT_VN}/src/requant"
}
