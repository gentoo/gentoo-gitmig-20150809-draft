# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/clustalw/clustalw-1.83-r1.ebuild,v 1.7 2004/11/20 23:51:07 sekretarz Exp $

inherit gcc

DESCRIPTION="General purpose multiple alignment program for DNA and proteins"
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="alpha ppc sparc x86 ~ppc-macos ~amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}${PV}

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i -e "s/CC	= cc/CC	= $(gcc-getCC)/" makefile
	sed -i -e "s/CFLAGS  = -c -O/CFLAGS  = -c ${CFLAGS}/" makefile
	sed -i -e "s/LFLAGS	= -O -lm/LFLAGS	= -lm ${CFLAGS}/" makefile
	sed -i -e "s%clustalw_help%/usr/share/doc/${PF}/clustalw_help%" clustalw.c
}

src_compile() {
	emake || die
}

src_install() {
	dobin clustalw || die
	dodoc README clustalv.doc clustalw.doc clustalw.ms
	insinto /usr/share/doc/${PF}
	doins clustalw_help
}
