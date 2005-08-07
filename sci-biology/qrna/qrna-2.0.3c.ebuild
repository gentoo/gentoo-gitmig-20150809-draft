# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/qrna/qrna-2.0.3c.ebuild,v 1.1 2005/08/07 14:21:59 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Prototype ncRNA genefinder"
HOMEPAGE="http://www.genetics.wustl.edu/eddy/software/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-lang/perl
	virtual/libc"

src_compile () {
	sed -e "s/CC = gcc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -O/CFLAGS = ${CFLAGS}/" \
		-i src/Makefile squid/Makefile
	sed -e "s/CC     = gcc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -g -O2/CFLAGS = ${CFLAGS}/" \
		-i squid02/Makefile
	cd ${S}/squid
	emake || die
	cd ${S}/squid02
	emake || die
	cd ${S}/src
	emake || die
}

src_install () {
	cd ${S}/src
	dobin cfgbuild eqrna eqrna_sample main rnamat_main shuffle
	cd ${S}/squid02
	dobin afetch alistat compalign compstruct revcomp seqsplit seqstat \
		sfetch shuffle sindex sreformat translate weight
	cd ${S}
	dobin scripts/*

	newdoc 00README
	insinto /usr/share/doc/${PF}
	doins documentation/*

	insinto /usr/share/${PN}/data
	doins lib/*
	insinto /usr/share/${PN}/demos
	doins Demos/*

	# Sets the path to the QRNA data files.
	insinto /etc/env.d
	doins ${FILESDIR}/26qrna
}
