# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98-r3.ebuild,v 1.1 2001/08/18 04:07:29 chadh Exp $

P=nasm-0.98
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="groovy little assembler"
SRC_URI="ftp://ftp.kernel.org/pub/software/devel/nasm/source/${A}
	 ftp://ftp.de.kernel.org/pub/software/devel/nasm/source/${A}
	 ftp://ftp.uk.kernel.org/pub/software/devel/nasm/source/${A}"
HOMEPAGE="http://nasm.sourceforge.net/"

DEPEND="virtual/glibc sys-apps/texinfo"
RDEPEND="virtual/glibc"

src_compile() {                           

    try ./configure --prefix=/usr 
    try make
    cd doc
    try make
}

src_install() {


	dobin nasm ndisasm
	dobin rdoff/ldrdf rdoff/rdf2bin rdoff/rdfdump rdoff/rdflib rdoff/rdx
	doman nasm.1 ndisasm.1
	dodoc COPYING Changes Licence MODIFIED Readme Wishlist
    docinto txt
    cd doc
    dodoc nasmdoc.txt
	docinto html
	dodoc html/*.html
    docinto ps
    dodoc nasmdoc.ps
    docinto rtf
    dodoc nasmdoc.rtf

	doinfo info/*.info*
}


