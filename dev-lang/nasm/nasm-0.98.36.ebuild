# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.36.ebuild,v 1.7 2004/04/16 02:29:47 vapier Exp $

inherit etuils

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
	cd ${S}
	use doc || epatch ${FILESDIR}/${P}-remove-doc-target.diff
}

src_compile() {
	./configure --prefix=/usr || die

	if use build ; then
		make nasm || die
	else
		make everything || die
	fi

}

src_install() {
	if use build ; then
		dobin nasm
	else
		dobin nasm ndisasm rdoff/{ldrdf,rdf2bin,rdf2ihx,rdfdump,rdflib,rdx}
		dosym /usr/bin/rdf2bin /usr/bin/rdf2com
		doman nasm.1 ndisasm.1
		dodoc AUTHORS CHANGES ChangeLog INSTALL README TODO
		if use doc ; then
			doinfo doc/info/*
			dohtml doc/html/*
			dodoc doc/nasmdoc.*
		fi
	fi
}
