# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prosite/prosite-18.42.ebuild,v 1.5 2005/02/02 21:34:41 j4rg0n Exp $

DESCRIPTION="A protein families and domains database"
HOMEPAGE="http://ca.expasy.org/prosite"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="swiss-prot"
SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE="no-emboss no-rawdb"

src_compile() {
	# Index the database for use with EMBOSS if EMBOSS is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/prosextract ] && ! use no-emboss; then
		mkdir PROSITE
		einfo "Indexing PROSITE for usage with EMBOSS."
		EMBOSS_DATA=. prosextract -auto -infdat ${S} || die \
			"Indexing PROSITE failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins ${PN}.{doc,dat,lis}
	fi
	dodoc *.txt
	dohtml prosuser.htm
	if [ -e /usr/bin/prosextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/PROSITE
		doins PROSITE/*
	fi
}
