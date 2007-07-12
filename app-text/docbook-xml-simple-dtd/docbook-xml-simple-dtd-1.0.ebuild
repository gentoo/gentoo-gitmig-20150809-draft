# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-1.0.ebuild,v 1.13 2007/07/12 09:15:03 uberlord Exp $

MY_PN="docbook-simple"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Simplified Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.oasis-open.org/docbook/xml/simple/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="1.0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND=">=app-arch/unzip-5.41
	${RDEPEND}"

S=${WORKDIR}

src_install() {
	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}
	doins *.dtd *.mod *.css || die
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
