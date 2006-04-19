# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6-r1.ebuild,v 1.3 2006/04/19 22:22:35 malc Exp $

inherit eutils

DESCRIPTION="Gramofile is an audio recording/editing program for recording of analog audio for digital remastering."
HOMEPAGE="http://www.opensourcepartners.nl/~costar/gramofile/"
SRC_URI="http://www.opensourcepartners.nl/~costar/${PN}/${P}.tar.gz
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3a.patch
	http://www.opensourcepartners.nl/~costar/${PN}/tappin3b.patch"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	=sci-libs/fftw-2*"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/tappin3a.patch
	epatch ${DISTDIR}/tappin3b.patch
	epatch ${FILESDIR}/${P}-64bit.patch
}

src_compile() {
	sed -i -e "s/CFLAGS = -Wall -O2 -DTURBO_MEDIAN -DTURBO_BUFFER/CFLAGS \= -Wall `echo ${CFLAGS}` -DTURBO_MEDIAN -DTURBO_BUFFER/" Makefile
	# We need the prototype on amd64 or basename defaults to returning int -
	# causint segfault... bug #128378
	sed -i -e "s/-DREDHAT50//" bplaysrc/Makefile
	make || die
}

src_install() {
	dobin gramofile bplay_gramo brec_gramo
	dodoc Signproc.txt  Tracksplit2.txt README ChangeLog TODO
}
