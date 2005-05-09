# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-0.98.38-r1.ebuild,v 1.4 2005/05/09 21:07:29 mr_bones_ Exp $

inherit eutils

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://nasm.sourceforge.net/"
SRC_URI="mirror://sourceforge/nasm/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="doc build"

DEPEND="!build? ( dev-lang/perl )
	doc? ( virtual/ghostscript
		sys-apps/texinfo )
	sys-devel/gcc"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-overflow.patch"
}

src_compile() {
	./configure --prefix=/usr || die

	if use build; then
		emake nasm || die "emake failed"
	else
		emake all || die "emake failed"
		emake rdf || die "emake failed"
		if use doc; then
			emake doc || die "emake failed"
		fi
	fi

}

src_install() {
	if use build; then
		dobin nasm || die "dobin failed"
	else
		dobin nasm ndisasm rdoff/{ldrdf,rdf2bin,rdf2ihx,rdfdump,rdflib,rdx} \
			|| die "dobin failed"
		dosym /usr/bin/rdf2bin /usr/bin/rdf2com
		doman nasm.1 ndisasm.1
		dodoc AUTHORS CHANGES ChangeLog INSTALL README TODO
		if use doc; then
			doinfo doc/info/*
			dohtml doc/html/*
			dodoc doc/nasmdoc.*
		fi
	fi
}
