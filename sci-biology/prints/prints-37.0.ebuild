# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prints/prints-37.0.ebuild,v 1.3 2005/02/02 21:32:12 j4rg0n Exp $

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
IUSE="no-emboss no-rawdb"

S=${WORKDIR}

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/printsextract ] && ! use no-emboss; then
		mkdir PRINTS
		einfo "Indexing PRINTS for usage with EMBOSS."
		EMBOSS_DATA=. printsextract -auto -infile prints37_0.dat || die \
			"Indexing PRINTS failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins ${PN}37_0.{all.fasta,dat,lis,nam,vsn} newpr.lis
	fi
	if [ -e /usr/bin/printsextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/PRINTS
		doins PRINTS/*
	fi
}
