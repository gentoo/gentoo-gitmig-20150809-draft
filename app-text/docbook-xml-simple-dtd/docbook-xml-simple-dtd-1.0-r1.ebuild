# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-1.0-r1.ebuild,v 1.8 2006/01/05 21:02:15 cryos Exp $

inherit sgml-catalog

MY_PN="docbook-simple"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Simplified Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.oasis-open.org/docbook/xml/simple/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="1.0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 mips ~ppc ~ppc64 s390 sparc x86"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND=">=app-arch/unzip-5.41
	${RDEPEND}"

S=${WORKDIR}

sgml-catalog_cat_include "/etc/sgml/xml-simple-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/${P#docbook-}/catalog"

src_install() {
	insinto /usr/share/sgml/docbook/${P#docbook-}
	doins *.dtd *.mod *.css
	newins ${FILESDIR}/${P}.cat catalog
}
