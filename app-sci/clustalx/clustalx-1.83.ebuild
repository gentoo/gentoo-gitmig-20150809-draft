# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/clustalx/clustalx-1.83.ebuild,v 1.3 2004/11/17 14:17:51 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Graphical interface for the ClustalW multiple alignment program"
HOMEPAGE="http://www-igbmc.u-strasbg.fr/BioInfo/ClustalX/"
SRC_URI="ftp://ftp-igbmc.u-strasbg.fr/pub/ClustalX/clustalx1.83.sun.tar.gz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-sci/ncbi-tools
	app-sci/clustalw
	virtual/x11"

S="${WORKDIR}/${PN}${PV}.sun"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp makefile.linux makefile
	sed -i -e "s/CC	= cc/CC	= $(tc-getCC)/" makefile
	sed -i -e "s/CFLAGS  = -c -O/CFLAGS  = -c ${CFLAGS}/" makefile
	sed -i -e "s/LFLAGS	= -O -lm/LFLAGS	= -lm ${CFLAGS}/" makefile
	sed -i -e "s%-I/usr/bio/src/ncbi/include%-I/usr/include/ncbi%" makefile
	sed -i -e "s%-L/usr/bio/src/ncbi/lib -L/usr/ccs/lib -L/usr/X11R6/lib%-L/usr/lib -L/usr/X11R6/lib%" makefile
	sed -i -e "s%clustalx_help%/usr/share/doc/${PF}/clustalx_help%" clustalx.c
	sed -i -e "s%clustalw.doc%../clustalw.doc%" clustalx.html
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
