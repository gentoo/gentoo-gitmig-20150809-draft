# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mup/mup-4.3.ebuild,v 1.5 2002/07/21 03:07:47 seemant Exp $

S=${WORKDIR}/${P}
MY_P="${PN}43"
DESCRIPTION="Mup is a shareware program for printing music. It takes an input file containing ordinary (ASCII) text describing music, and produces PostScript output for printing the musical score described by the input."
SRC_URI="ftp://ftp.arkkra.com/pub/unix/${MY_P}src.tar.gz
ftp://ftp.arkkra.com/pub/unix/${MY_P}doc.tar.gz"
HOMEPAGE="http://www.arkkra.com"

DEPEND="virtual/x11
	>=media-libs/svgalib-1.4.3"

SLOT="0"
LICENSE="Arkkra"
KEYWORDS="x86"

src_unpack() {

	mkdir ${P}
	mkdir ${P}/doc
	
	cd ${WORKDIR}/${P}
	unpack mup43src.tar.gz
	
	cd doc
	unpack mup43doc.tar.gz

}

src_compile() {

	cd ${S}/mup
	cc -o mup *.c -lm
	
	cd ${S}/mupdisp
	cc -o mupdisp *.c -lm -lvga -lX11 -L/usr/X11R6/lib
	
	cd ${S}/mkmupfnt
	cc -o mkmupfnt *.c
	
}

src_install () {

	dobin mup/mup
	dobin mupdisp/mupdisp
	dobin mkmupfnt/mkmupfnt
	dobin mupprnt
	
	dodoc license.txt README0
	cd doc
	dodoc faq.txt license.txt mupfeat.txt overview.txt register.txt README1
	dodoc mkmupfnt.ps mupdisp.ps mupprnt.ps mup.ps mupqref.ps oddeven.ps uguide.ps
	doman mup.1 mupdisp.1 mupprnt.1
	dodoc sample.mup sample.ps star.mup star.ps template.mup
	dohtml uguide/*

}
