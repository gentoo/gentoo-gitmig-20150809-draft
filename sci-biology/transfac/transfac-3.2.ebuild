# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/transfac/transfac-3.2.ebuild,v 1.2 2005/01/01 07:31:32 j4rg0n Exp $

DESCRIPTION="A database of eucaryotic transcription factors"
HOMEPAGE="http://www.gene-regulation.com/pub/databases.html"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/databases/${PN}/${PN}32.tar.Z"
LICENSE="public-domain"

SLOT="3"
KEYWORDS="x86 ~ppc ~ppc-macos"
IUSE="no-emboss no-rawdb"

S=${WORKDIR}

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/tfextract ] && ! use no-emboss; then
		einfo "Indexing TRANSFAC for usage with EMBOSS."
		EMBOSS_DATA=. tfextract -auto -infile class.dat  || die \
			"Indexing TRANSFAC failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}-${SLOT}
		doins *.dat
	fi
	if [ -e /usr/bin/tfextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data
		doins tf*
	fi
}
