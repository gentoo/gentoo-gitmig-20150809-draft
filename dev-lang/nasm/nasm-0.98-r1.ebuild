# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98-r1.ebuild,v 1.1 2000/08/07 18:11:23 achim Exp $

P=nasm-0.98
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="groovy little assembler"
CATEGORY=dev-lang
SRC_URI="ftp://ftp.kernel.org/pub/software/devel/nasm/source/nasm-0.98.tar.bz2"
HOMEPAGE="http://nasm.sourceforge.net/"

src_compile() {                           
    ./configure --prefix=/usr 
    make
    cd doc
    make
}

src_install() { 
	into /usr
	dobin nasm ndisasm
	dobin rdoff/ldrdf rdoff/rdf2bin rdoff/rdfdump rdoff/rdflib rdoff/rdx
	doman nasm.1 ndisasm.1
	dodoc COPYING Changes Licence MODIFIED Readme Wishlist doc/nasmdoc.txt
	docinto html
	dodoc doc/html/*.html
	doinfo doc/info/*.info*
}


