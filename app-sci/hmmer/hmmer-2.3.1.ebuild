# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/hmmer/hmmer-2.3.1.ebuild,v 1.2 2003/09/06 22:23:06 msterret Exp $

DESCRIPTION="HMMER - Biological sequence analysis with profile HMMs"
HOMEPAGE="http://hmmer.wustl.edu/"
SRC_URI="ftp://ftp.genetics.wustl.edu/pub/eddy/hmmer/2.3.1/hmmer-2.3.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=${D}/usr \
		--exec_prefix=${D}/usr \
		--mandir=${D}/usr/share/man || die "./configure failed"

#	econf || die
	emake || die
}

src_install() {

	dodir usr/bin
	dodir usr/share/man/man1

	einstall || die

	dodoc 00README COPYRIGHT INSTALL LICENSE NOTES Userguide.pdf

	cd squid

	dobin afetch  alistat compalign compstruct revcomp seqstat seqsplit sfetch shuffle sreformat sindex weight translate

}

