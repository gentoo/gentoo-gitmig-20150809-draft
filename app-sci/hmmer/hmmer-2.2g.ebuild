# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/hmmer/hmmer-2.2g.ebuild,v 1.1 2003/05/07 18:47:31 avenj Exp $

DESCRIPTION="HMMER - Biological sequence analysis with profile HMMs"
HOMEPAGE="http://hmmer.wustl.edu/"
SRC_URI="ftp://ftp.genetics.wustl.edu/pub/eddy/hmmer/CURRENT/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${P}

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile-${P}.patch
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=${D}/usr \
		--mandir=${D}/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {

	dodir usr/bin
	dodir usr/share/man/man1
	
	einstall || die
	
	dodoc 00README COPYRIGHT INSTALL LICENSE NOTES Userguide.pdf

	# include the squid docs
	dodoc squid/Docs/*.tex

}
