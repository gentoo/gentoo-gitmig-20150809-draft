# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/aaindex/aaindex-6.0.ebuild,v 1.4 2005/02/23 03:59:50 ribosome Exp $

DESCRIPTION="Amino acid indices and similarity matrices"
HOMEPAGE="http://www.genome.ad.jp/aaindex"
SRC_URI="ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}.doc
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}1
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}2
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/list_of_matrices
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/list_of_indices"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

S=${WORKDIR}

src_unpack() {
	echo
	einfo "No archive to unpack."
	echo
}

src_compile() {
	if use emboss; then
		mkdir AAINDEX
		echo
		einfo "Indexing AAindex for usage with EMBOSS."
		EMBOSS_DATA=. aaindexextract -auto -infile ${DISTDIR}/${PN}1 || die \
			"Indexing AAindex failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${DISTDIR}/{${PN}{1,2},list_of_{matrices,indices}}
	fi
	dodoc ${DISTDIR}/${PN}.doc
	if use emboss; then
		insinto /usr/share/EMBOSS/data/AAINDEX
		doins AAINDEX/*
	fi
}
