# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw/clustalw-1.83-r1.ebuild,v 1.6 2005/06/19 19:38:59 corsair Exp $

inherit toolchain-funcs

DESCRIPTION="General purpose multiple alignment program for DNA and proteins"
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}${PV}

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i -e "s/CC	= cc/CC	= $(tc-getCC)/" \
		-e "s/CFLAGS  = -c -O/CFLAGS  = -c ${CFLAGS}/" \
		-e "s/LFLAGS	= -O -lm/LFLAGS	= -lm ${CFLAGS}/" makefile || die
	sed -i -e "s%clustalw_help%/usr/share/doc/${PF}/clustalw_help%" clustalw.c || die
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
