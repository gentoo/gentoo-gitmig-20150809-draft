# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.36.ebuild,v 1.4 2003/09/05 13:22:04 vapier Exp $

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://nasm.sourceforge.net/"
SRC_URI="mirror://sourceforge/nasm/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* x86"
IUSE="doc build"

DEPEND="!build? ( dev-lang/perl )
	doc? ( app-text/ghostscript sys-apps/texinfo )
	sys-devel/gcc"

src_unpack() {
	unpack ${A}

	[ -z "`use doc`" ] && cd ${S} && epatch ${FILESDIR}/${P}-remove-doc-target.diff
}

src_compile() {
	./configure --prefix=/usr || die

	if [ `use build` ] ; then
		make nasm
	else
		make everything || die
	fi
	
}

src_install() {
	if [ `use build` ] ; then
		dobin nasm
	else
		dobin nasm ndisasm rdoff/{ldrdf,rdf2bin,rdf2ihx,rdfdump,rdflib,rdx}
		dosym /usr/bin/rdf2bin /usr/bin/rdf2com
		doman nasm.1 ndisasm.1
		dodoc AUTHORS CHANGES COPYING ChangeLog INSTALL README TODO
		if [ `use doc` ] ; then
			doinfo doc/info/*
			dohtml doc/html/*
			dodoc doc/nasmdoc.*
		fi
	fi
}
