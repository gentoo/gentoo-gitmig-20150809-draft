# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.31-r1.ebuild,v 1.6 2002/08/16 22:48:25 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="groovy little assembler"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2
	http://telia.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2
	http://belnet.dl.sourceforge.net/sourceforge/nasm/${P}.tar.bz2"
HOMEPAGE="http://nasm.sourceforge.net/"

DEPEND="virtual/glibc build? ( sys-devel/perl )
	doc? ( app-text/ghostscript sys-apps/texinfo )
	sys-devel/gcc"
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 -ppc sparc sparc64"

src_unpack() {

	cd ${WORKDIR}
	unpack ${A}

	if [ -z "`use doc`" ]; then
		cd ${S}
	patch -p0 < ${FILESDIR}/${P}-remove-doc-target.diff
	fi

}

src_compile() {			   

	./configure --prefix=/usr || die

	if [ "`use build`" ]; then
		make nasm 
	else
		make everything || die
	fi
	
}

src_install() {

	if [ "`use build`" ]; then
	dobin nasm
	else
	dobin nasm ndisasm rdoff/{ldrdf,rdf2bin,rdf2ihx,rdfdump,rdflib,rdx}
	dosym /usr/bin/rdf2bin /usr/bin/rdf2com
	doman nasm.1 ndisasm.1
	dodoc AUTHORS CHANGES COPYING ChangeLog INSTALL README TODO
	if [ -n "`use doc`" ]; then
		doinfo doc/info/*
		dohtml doc/html/*
		dodoc doc/nasmdoc.*
	fi
	fi

}
