# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/cutg/cutg-147-r1.ebuild,v 1.3 2005/08/06 19:13:09 ribosome Exp $

DESCRIPTION="Codon usage tables calculated from GenBank"
HOMEPAGE="http://www.kazusa.or.jp/codon/"
SRC_URI="ftp://ftp.kazusa.or.jp/pub/codon/current/compressed/CUTG.${PV}.tar.gz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~ppc64 x86"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

DEPEND="emboss? ( sci-biology/emboss )"

S=${WORKDIR}

src_compile() {
	if use emboss; then
		mkdir CODONS
		echo
		einfo "Indexing CUTG for usage with EMBOSS."
		EMBOSS_DATA="." cutgextract -auto -directory ${S} || die \
			"Indexing CUTG failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		mkdir -p ${D}usr/share/${PN}
		mv *.codon *.spsum ${D}usr/share/${PN} || die \
			"Installing raw CUTG database failed."
	fi
	dodoc README
	if use emboss; then
		mkdir -p ${D}usr/share/EMBOSS/data/CODONS
		cd CODONS
		for file in *; do
			mv ${file} ${D}usr/share/EMBOSS/data/CODONS || die \
				"Installing the EMBOSS-indexed database failed."
		done
	fi
}
