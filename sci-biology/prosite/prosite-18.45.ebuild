# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prosite/prosite-18.45.ebuild,v 1.4 2005/03/26 19:22:19 j4rg0n Exp $

DESCRIPTION="A protein families and domains database"
HOMEPAGE="http://ca.expasy.org/prosite"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="swiss-prot"
SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

DEPEND="emboss? ( sci-biology/emboss )"

src_compile() {
	if use emboss; then
		mkdir PROSITE
		echo
		einfo "Indexing PROSITE for usage with EMBOSS."
		EMBOSS_DATA="." prosextract -auto -infdat ${S} || die \
			"Indexing PROSITE failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${PN}.{doc,dat,lis}
	fi
	dodoc *.txt
	dohtml prosuser.htm
	if use emboss; then
		insinto /usr/share/EMBOSS/data/PROSITE
		doins PROSITE/*
	fi
}
