# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gentoo-guide-xml-dtd/gentoo-guide-xml-dtd-2.1-r1.ebuild,v 1.3 2003/09/05 22:37:21 msterret Exp $

inherit sgml-catalog

S=${WORKDIR}
DESCRIPTION="DTD for Gentoo-Guide Style XML Files"
HOMEPAGE="http://www.gentoo.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

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
