# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prints/prints-37.0.ebuild,v 1.8 2005/06/19 19:46:20 corsair Exp $

DESCRIPTION="A protein motif fingerprint database"
HOMEPAGE="http://www.bioinf.man.ac.uk/dbbrowser/PRINTS/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/databases/${PN}/newpr.lis.gz
	ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}37_0.all.fasta.Z
	ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}37_0.dat.gz
	ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}37_0.lis.gz
	ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}37_0.nam.gz
	ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}37_0.vsn.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="ppc ppc-macos ppc64 x86"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

DEPEND="emboss? ( sci-biology/emboss )"

S=${WORKDIR}

src_compile() {
	if use emboss; then
		mkdir PRINTS
		echo
		einfo "Indexing PRINTS for usage with EMBOSS."
		EMBOSS_DATA=. printsextract -auto -infile prints37_0.dat || die \
			"Indexing PRINTS failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${PN}37_0.{all.fasta,dat,lis,nam,vsn} newpr.lis
	fi
	if use emboss; then
		insinto /usr/share/EMBOSS/data/PRINTS
		doins PRINTS/*
	fi
}
