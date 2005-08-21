# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prosite/prosite-19.8.ebuild,v 1.1 2005/08/21 22:10:11 ribosome Exp $

DESCRIPTION="A protein families and domains database"
HOMEPAGE="http://ca.expasy.org/prosite"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="swiss-prot"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos ~ppc64"
IUSE="emboss minimal"
# Minimal build keeps only the indexed files (if applicable) and the documentation.
# The non-indexed database is not installed.

DEPEND="emboss? ( >=sci-biology/emboss-3.0.0 )"

src_compile() {
	if use emboss; then
		mkdir PROSITE
		echo
		einfo "Indexing PROSITE for usage with EMBOSS."
		EMBOSS_DATA="." prosextract -auto -prositedir ${S} || die \
			"Indexing PROSITE failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins ${PN}.{doc,dat,lis} || die
	fi
	dodoc *.txt || die
	dohtml *.htm || die
	if use emboss; then
		insinto /usr/share/EMBOSS/data/PROSITE
		doins PROSITE/* || die
	fi
}
