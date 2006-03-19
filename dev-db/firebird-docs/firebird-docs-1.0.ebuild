# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird-docs/firebird-docs-1.0.ebuild,v 1.16 2006/03/19 19:14:49 halcy0n Exp $

S="${WORKDIR}"
DESCRIPTION="A relational database offering many ANSI SQL-92 features"
SRC_URI="mirror://sourceforge/firebird/Firebird_v1_ReleaseNotes.pdf
	ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip"
HOMEPAGE="http://firebird.sourceforge.net/"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 ppc ~sparc"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""

src_unpack() {
	mkdir ${WORKDIR}/manuals
	cd ${WORKDIR}/manuals
	unpack ib_b60_doc.zip
}

src_compile() {
	einfo "Nothing to compile"
}

src_install () {
	dodir /usr/share/doc/${P}
	cp -pPR ${DISTDIR}/Firebird_v1_ReleaseNotes.pdf ${D}/usr/share/doc/${P}
	cp -pPR ${WORKDIR}/manuals ${D}/usr/share/doc/${P}
}
