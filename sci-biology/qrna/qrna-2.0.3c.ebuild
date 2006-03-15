# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/qrna/qrna-2.0.3c.ebuild,v 1.7 2006/03/15 02:49:37 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Prototype ncRNA genefinder"
HOMEPAGE="http://www.genetics.wustl.edu/eddy/software/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_compile () {
	sed -e "s/CC = gcc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -O/CFLAGS = ${CFLAGS}/" \
		-i src/Makefile squid/Makefile
	sed -e "s/CC     = gcc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -g -O2/CFLAGS = ${CFLAGS}/" \
		-i squid02/Makefile
	cd "${S}"/squid
	emake || die
	cd "${S}"/squid02
	emake || die
	cd "${S}"/src
	emake || die
}

src_install () {
	cd "${S}"/src
	dobin cfgbuild eqrna eqrna_sample main rnamat_main shuffle || die
	cd "${S}"/squid02
	dobin afetch alistat compalign compstruct revcomp seqsplit seqstat \
		sfetch shuffle sindex sreformat translate weight || die
	cd "${S}"
	dobin scripts/* || die

	newdoc 00README README || die
	insinto /usr/share/doc/${PF}
	doins documentation/* || die

	insinto /usr/share/${PN}/data
	doins lib/* || die
	insinto /usr/share/${PN}/demos
	doins Demos/* || die

	# Sets the path to the QRNA data files.
	insinto /etc/env.d
	doins "${FILESDIR}"/26qrna || die
}
