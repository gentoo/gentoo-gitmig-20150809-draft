# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gentoo-guide-xml-dtd/gentoo-guide-xml-dtd-2.1-r1.ebuild,v 1.8 2004/07/13 21:13:25 agriffis Exp $

inherit sgml-catalog

S=${WORKDIR}
DESCRIPTION="DTD for Gentoo-Guide Style XML Files"
HOMEPAGE="http://www.gentoo.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc s390"
IUSE=""

DEPEND=">=app-text/sgml-common-0.6.1"

src_install () {

	cd ${FILESDIR}

	insinto /usr/share/sgml/guide
	doins catalog
	insinto /usr/share/sgml/guide/ent
	doins ent/*.ent
	insinto /usr/share/sgml/guide/xml-dtd-2.1
	newins guide/guide-2.1.dtd guide.dtd

}

sgml-catalog_cat_include "/etc/sgml/gentoo-guide.cat" \
	"/usr/share/sgml/guide/catalog"
