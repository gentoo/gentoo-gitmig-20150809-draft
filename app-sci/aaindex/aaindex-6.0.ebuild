# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/aaindex/aaindex-6.0.ebuild,v 1.5 2004/11/03 02:47:42 j4rg0n Exp $

DESCRIPTION="Amino acid indices and similarity matrices"
HOMEPAGE="http://www.genome.ad.jp/${PN}/"
SRC_URI="ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}.doc
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}1
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/${PN}2
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/list_of_matrices
	ftp://ftp.genome.ad.jp/pub/db/genomenet/${PN}/list_of_indices"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc-macos"
IUSE="no-emboss no-rawdb"

S=${WORKDIR}

src_unpack() {
	einfo "No archive to unpack."
}

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/aaindexextract ] && ! use no-emboss; then
		mkdir AAINDEX
		einfo "Indexing AAindex for usage with EMBOSS."
		EMBOSS_DATA=. aaindexextract -auto -infile ${DISTDIR}/${PN}1 || die \
			"Indexing AAindex failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins ${DISTDIR}/{${PN}{1,2},list_of_{matrices,indices}}
	fi
	dodoc ${DISTDIR}/${PN}.doc
	if [ -e /usr/bin/aaindexextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/AAINDEX
		doins AAINDEX/*
	fi
}
