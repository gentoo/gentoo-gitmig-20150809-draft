# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/transfac/transfac-3.2.ebuild,v 1.5 2005/02/23 04:26:01 ribosome Exp $

DESCRIPTION="A database of eucaryotic transcription factors"
HOMEPAGE="http://www.gene-regulation.com/pub/databases.html"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}32.tar.Z"
LICENSE="public-domain"

SLOT="3"
KEYWORDS="x86 ~ppc ppc-macos ~ppc64"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

S=${WORKDIR}

src_compile() {
	if use emboss; then
		echo
		einfo "Indexing TRANSFAC for usage with EMBOSS."
		EMBOSS_DATA=. tfextract -auto -infile class.dat  || die \
			"Indexing TRANSFAC failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}-${SLOT}
		doins *.dat
	fi
	if use emboss; then
		insinto /usr/share/EMBOSS/data
		doins tf*
	fi
}
