# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/rebase/rebase-502.ebuild,v 1.1 2005/02/03 00:37:49 ribosome Exp $

DESCRIPTION="A restriction enzyme database"
HOMEPAGE="http://rebase.neb.com"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~ppc-macos"
IUSE="no-emboss no-rawdb"

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/rebaseextract ] && ! use no-emboss; then
		einfo "Indexing ${PN} for usage with EMBOSS."
		mkdir REBASE
		EMBOSS_DATA=. rebaseextract -auto -infile withrefm.${PV} \
			-protofile proto.${PV} || die "Indexing ${PN} failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins withrefm.${PV} proto.${PV}
	fi
	newdoc REBASE.DOC README
	if [ -e /usr/bin/rebaseextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/REBASE
		doins REBASE/{embossre.enz,embossre.ref,embossre.sup}
	fi
}
