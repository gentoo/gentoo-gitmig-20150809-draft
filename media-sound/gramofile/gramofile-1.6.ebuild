# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6.ebuild,v 1.14 2004/09/14 16:32:50 eradicator Exp $

inherit eutils

DESCRIPTION="Gramofile is an audio recording/editing program whose main goal is to allow recording of analog audio for digital remastering."
HOMEPAGE="http://panic.et.tudelft.nl/~costar/gramofile/"
SRC_URI="http://panic.et.tudelft.nl/~costar/gramofile/${P}.tar.gz
	http://panic.et.tudelft.nl/~costar/gramofile/tappin3a.patch
	http://panic.et.tudelft.nl/~costar/gramofile/tappin3b.patch"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 sparc amd64"
IUSE=""

DEPEND="sys-libs/ncurses \
	=dev-libs/fftw-2*"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/tappin3a.patch
	epatch ${DISTDIR}/tappin3b.patch
}

src_compile() {
	sed -i -e "s/CFLAGS = -Wall -O2 -DTURBO_MEDIAN -DTURBO_BUFFER/CFLAGS \= -Wall `echo ${CFLAGS}` -DTURBO_MEDIAN -DTURBO_BUFFER/" Makefile
	make || die
}

src_install() {
	dobin gramofile bplay_gramo brec_gramo
	dodoc Signproc.txt  Tracksplit2.txt README ChangeLog TODO
}
