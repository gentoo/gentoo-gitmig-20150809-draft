# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/prosite/prosite-18.36.ebuild,v 1.2 2004/10/31 03:11:29 ribosome Exp $

DESCRIPTION="A protein families and domains database"
HOMEPAGE="http://ca.expasy.org/${PN}"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="swiss-prot"
SLOT="0"
KEYWORDS="x86 ~ppc"
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
