# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.30.ebuild,v 1.1 2002/05/06 08:20:25 kain Exp

S=${WORKDIR}/${P}
DESCRIPTION="groovy little assembler"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2
http://telia.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2
http://belnet.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2"
HOMEPAGE="http://nasm.2y.net/"

DEPEND="virtual/glibc sys-apps/texinfo"
RDEPEND="virtual/glibc"

if [ -z "`use build`" ]; then
	DEPEND="${DEPEND} sys-devel/perl"
fi

src_compile() {                           
	./configure --prefix=/usr || die

	if [ "`use build`" ]; then
		make nasm
	else
		make || die
		cd doc
		make || die
	fi
}

src_install() {
	if [ "`use build`" ]; then
		dobin nasm
	else
		dobin nasm ndisasm
		dobin rdoff/ldrdf rdoff/rdf2bin rdoff/rdfdump rdoff/rdflib rdoff/rdx
		doman nasm.1 ndisasm.1
		dodoc COPYING Changes Licence MODIFIED Readme Wishlist
		docinto txt
		cd doc
    	dodoc nasmdoc.txt
		dohtml html/*.html
    	docinto ps
    	dodoc nasmdoc.ps
    	docinto rtf
    	dodoc nasmdoc.rtf

		doinfo info/*.info*
	fi
}
