# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.38.ebuild,v 1.4 2004/01/31 02:17:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://nasm.sourceforge.net/"
SRC_URI="mirror://sourceforge/nasm/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* x86"
IUSE="doc build"

DEPEND="!build? ( dev-lang/perl )
	doc? ( virtual/ghostscript sys-apps/texinfo )
	sys-devel/gcc"

src_unpack() {
	unpack ${A}

	[ -z "`use doc`" ] && cd ${S} && epatch ${FILESDIR}/nasm-0.98.36-remove-doc-target.diff
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
		dodoc AUTHORS CHANGES ChangeLog INSTALL README TODO
		if [ `use doc` ] ; then
			doinfo doc/info/*
			dohtml doc/html/*
			dodoc doc/nasmdoc.*
		fi
	fi
}
