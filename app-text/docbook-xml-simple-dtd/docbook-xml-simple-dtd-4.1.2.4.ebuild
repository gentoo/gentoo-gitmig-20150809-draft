# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-4.1.2.4.ebuild,v 1.16 2003/09/05 22:37:21 msterret Exp $

MY_P="sdb4124"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.nwalsh.com/docbook/simple/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
SLOT="0"
LICENSE="X11"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {
	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}
	doins *.dtd *.mod *.css

	#newins ${FILESDIR}/${P}.catalog catalog

	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}/ent
	doins ent/*.ent

	dodoc README ChangeLog LostLog COPYRIGHT
}
