# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6.ebuild,v 1.6 2003/09/08 07:09:44 msterret Exp $

DESCRIPTION="Gramofile"
HOMEPAGE="http://panic.et.tudelft.nl/~costar/gramofile/"
SRC_URI="http://panic.et.tudelft.nl/~costar/gramofile/${P}.tar.gz
        http://panic.et.tudelft.nl/~costar/gramofile/tappin3a.patch
        http://panic.et.tudelft.nl/~costar/gramofile/tappin3b.patch"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses \
        dev-libs/fftw"

S=${WORKDIR}/${P}

src_unpack() {
        unpack ${P}.tar.gz
        cd ${S}
        patch < ${DISTDIR}/tappin3a.patch
        patch < ${DISTDIR}/tappin3b.patch
}

src_compile() {
	sed -e "s/CFLAGS = -Wall -O2 -DTURBO_MEDIAN -DTURBO_BUFFER/CFLAGS \= -Wall `echo ${CFLAGS}` -DTURBO_MEDIAN -DTURBO_BUFFER/" Makefile > Makefile.new
	mv Makefile.new Makefile
	make || die
}

src_install() {
	dobin gramofile bplay_gramo brec_gramo
    dodoc Signproc.txt  Tracksplit2.txt README ChangeLog TODO
}

