# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-1.0.ebuild,v 1.7 2004/11/06 14:03:48 usata Exp $

MY_PN="docbook-simple"
MY_P=${MY_PN}-${PV}

S=${WORKDIR}

DESCRIPTION="Simplified Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/simple/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"
LICENSE="X11"

KEYWORDS="x86 ppc ~sparc alpha ~hppa ~amd64 mips ppc64"
SLOT="1.0"
IUSE=""

RDEPEND="dev-libs/libxml2"

DEPEND=">=app-arch/unzip-5.41
	${RDEPEND}"

src_install() {

	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}
	doins *.dtd *.mod *.css

}

pkg_postinst() {

	# and now enter the simplified docbook dtd to the catalog
	CATALOG=/etc/xml/catalog

	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/simple/${PV}" \
		"/usr/share/sgml/docbook/xml-simple-dtd-${PV}" \
		${CATALOG}

	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/simple/${PV}" \
		"/usr/share/sgml/docbook/xml-simple-dtd-${PV}" \
		${CATALOG}

}

pkg_postrm() {

	# and clean up the catalog when we're finished
	CATALOG=/etc/xml/catalog
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xml-simple-dtd-${PV}" \
		${CATALOG}

}
