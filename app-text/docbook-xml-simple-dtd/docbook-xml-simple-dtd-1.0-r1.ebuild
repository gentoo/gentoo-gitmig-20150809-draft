# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-1.0-r1.ebuild,v 1.1 2004/11/06 14:03:48 usata Exp $

inherit sgml-catalog

MY_PN="docbook-simple"
MY_P=${MY_PN}-${PV}

S=${WORKDIR}

DESCRIPTION="Simplified Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/simple/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"
LICENSE="X11"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips ~ppc64"
SLOT="1.0"
IUSE=""

RDEPEND="dev-libs/libxml2"

DEPEND=">=app-arch/unzip-5.41
	${RDEPEND}"

sgml-catalog_cat_include "/etc/sgml/xml-simple-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/${P#docbook-}/catalog"

src_install() {

	insinto /usr/share/sgml/docbook/${P#docbook-}
	doins *.dtd *.mod *.css
	newins ${FILESDIR}/${P}.cat catalog
}
