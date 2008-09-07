# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/qrna/qrna-2.0.3c.ebuild,v 1.12 2008/09/07 11:23:57 markusle Exp $

inherit toolchain-funcs

DESCRIPTION="Prototype ncRNA genefinder"
HOMEPAGE="http://selab.janelia.org/software.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/perl
	sci-biology/hmmer"

src_compile () {
	sed -e "s/CC = gcc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -O/CFLAGS = ${CFLAGS}/" \
		-i src/Makefile squid/Makefile

	cd "${S}"/squid
	emake || die

	cd "${S}"/src
	emake || die
}

src_install () {
	cd "${S}"/src
	dobin cfgbuild eqrna eqrna_sample main rnamat_main || die

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
	doenvd "${FILESDIR}"/26qrna || die
}
