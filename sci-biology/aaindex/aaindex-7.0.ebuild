# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/aaindex/aaindex-7.0.ebuild,v 1.7 2006/08/18 02:46:19 weeve Exp $

DESCRIPTION="Amino acid indices and similarity matrices"
LICENSE="public-domain"
HOMEPAGE="http://www.genome.ad.jp/aaindex"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
# Minimal build keeps only the indexed files (if applicable) and the
# documentation. The non-indexed database is not installed.
IUSE="emboss minimal"
KEYWORDS="amd64 ppc ppc-macos ppc64 ~sparc x86"

DEPEND="emboss? ( sci-biology/emboss )"

src_compile() {
	if use emboss; then
		mkdir AAINDEX
		echo
		einfo "Indexing AAindex for usage with EMBOSS."
		EMBOSS_DATA="." aaindexextract -auto -infile ${PN}1 || die \
			"Indexing AAindex failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${PN}{1,2} || die "Failed to install raw database."
	fi
	dodoc ${PN}.doc
	if use emboss; then
		insinto /usr/share/EMBOSS/data/AAINDEX
		doins AAINDEX/* || die "Failed to install EMBOSS data files."
	fi
}
