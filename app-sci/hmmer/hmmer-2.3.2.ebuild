# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/hmmer/hmmer-2.3.2.ebuild,v 1.4 2004/11/01 01:53:06 ribosome Exp $

DESCRIPTION="HMMER - Biological sequence analysis with profile HMMs"
HOMEPAGE="http://hmmer.wustl.edu/"
SRC_URI="ftp://ftp.genetics.wustl.edu/pub/eddy/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc-macos ~ppc"
IUSE=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=${D}/usr \
		--exec_prefix=${D}/usr \
		--mandir=${D}/usr/share/man || die

#	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc 00README NOTES

	insinto /usr/share/doc/${PF}
	doins Userguide.pdf

	cd squid

	dobin afetch alistat compalign compstruct revcomp seqstat seqsplit sfetch shuffle sreformat sindex weight translate
	dolib libsquid.a
}

src_test() {
	make check
}
