# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/rebase/rebase-406.ebuild,v 1.3 2004/07/09 21:42:18 mr_bones_ Exp $

DESCRIPTION="A restriction enzyme database"
HOMEPAGE="http://${PN}.neb.com"
SRC_URI="ftp://ftp.neb.com/pub/${PN}/withrefm.${PV} \
	ftp://ftp.neb.com/pub/${PN}/proto.${PV} \
	ftp://ftp.neb.com/pub/${PN}/REBASE.DOC"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="no-emboss no-rawdb"

S=${WORKDIR}

src_unpack() {
	einfo "No archive to unpack."
}

src_compile() {
	# Index the database for use with emboss if emboss is installed and
	# the user did not explicitly request not to index the database.
	if [ -e /usr/bin/rebaseextract ] && ! use no-emboss; then
		einfo "Indexing ${PN} for usage with EMBOSS."
		mkdir REBASE
		EMBOSS_DATA=. rebaseextract -auto -infile ${DISTDIR}/withrefm.${PV} \
			-protofile ${DISTDIR}/proto.${PV} || die \
			"Indexing ${PN} failed."
	fi
}

src_install() {
	if ! use no-rawdb; then
		insinto /usr/share/${PN}
		doins ${DISTDIR}/withrefm.${PV} ${DISTDIR}/proto.${PV}
	fi
	newdoc ${DISTDIR}/REBASE.DOC README
	if [ -e /usr/bin/rebaseextract ] && ! use no-emboss; then
		insinto /usr/share/EMBOSS/data/REBASE
		doins REBASE/{embossre.enz,embossre.ref,embossre.sup}
	fi
}
