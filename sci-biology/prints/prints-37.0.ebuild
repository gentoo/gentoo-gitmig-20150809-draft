# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prints/prints-37.0.ebuild,v 1.4 2005/02/23 04:06:27 ribosome Exp $

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
KEYWORDS="x86 ~ppc ppc-macos"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

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
