# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw/clustalw-1.83-r1.ebuild,v 1.3 2005/01/14 22:24:13 j4rg0n Exp $

inherit toolchain-funcs

DESCRIPTION="General purpose multiple alignment program for DNA and proteins"
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="alpha ppc sparc x86 ppc-macos ~amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}${PV}

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i -e "s/CC	= cc/CC	= $(tc-getCC)/" makefile
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
