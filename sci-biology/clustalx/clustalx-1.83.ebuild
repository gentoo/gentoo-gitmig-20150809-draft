# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalx/clustalx-1.83.ebuild,v 1.4 2005/02/02 21:10:49 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Graphical interface for the ClustalW multiple alignment program"
HOMEPAGE="http://www-igbmc.u-strasbg.fr/BioInfo/ClustalX/"
SRC_URI="ftp://ftp-igbmc.u-strasbg.fr/pub/ClustalX/clustalx1.83.sun.tar.gz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="sci-biology/clustalw
	sci-biology/ncbi-tools
	virtual/x11"

S="${WORKDIR}/${PN}${PV}.sun"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp makefile.linux makefile
	sed -e "s/CC	= cc/CC	= $(tc-getCC)/" \
		-e "s/CFLAGS  = -c -O/CFLAGS  = -c ${CFLAGS}/" \
		-e "s/LFLAGS	= -O -lm/LFLAGS	= -lm ${CFLAGS}/" \
		-e "s%-I/usr/bio/src/ncbi/include%-I/usr/include/ncbi%" \
		-e "s%-L/usr/bio/src/ncbi/lib -L/usr/ccs/lib -L/usr/X11R6/lib%-L/usr/lib -L/usr/X11R6/lib%" \
		-i makefile || die
	sed -i -e "s%clustalx_help%/usr/share/doc/${PF}/clustalx_help%" clustalx.c || die
	sed -i -e "s%clustalw.doc%../clustalw.doc%" clustalx.html || die
}

src_compile() {
	make || die
}

src_install() {
	dobin clustalx

	dodoc README_X
	dohtml clustalx.html

	insinto /usr/share/doc/${PF}
	doins clustalx_help clustalw.doc
}
