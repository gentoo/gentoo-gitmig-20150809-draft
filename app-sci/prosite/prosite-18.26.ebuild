# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/prosite/prosite-18.26.ebuild,v 1.4 2004/08/11 00:35:43 ribosome Exp $

DESCRIPTION="A protein families and domains database"
HOMEPAGE="http://ca.expasy.org/${PN}"
SRC_URI="ftp://ca.expasy.org/databases/${PN}/release/${PN}.doc \
	ftp://ca.expasy.org/databases/${PN}/release/${PN}.lis \
	ftp://ca.expasy.org/databases/${PN}/release/${PN}.dat \
	ftp://ca.expasy.org/databases/${PN}/release/prosuser.htm \
	ftp://ca.expasy.org/databases/${PN}/release/prosuser.txt"
LICENSE="swiss-prot"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="no-emboss no-rawdb"

S=${WORKDIR}

src_unpack() {
	einfo "No archive to unpack."
}

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/prosextract ] && ! use no-emboss; then
		mkdir PROSITE
		einfo "Indexing PROSITE for usage with EMBOSS."
		EMBOSS_DATA=. prosextract -auto -infdat ${DISTDIR} || die \
			"Indexing PROSITE failed."
	fi
}


src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins ${DISTDIR}/${PN}.{doc,dat,lis}
	fi
	dodoc ${DISTDIR}/prosuser.txt
	dohtml ${DISTDIR}/prosuser.htm
	if [ -e /usr/bin/prosextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/PROSITE
		doins PROSITE/*
	fi
}
