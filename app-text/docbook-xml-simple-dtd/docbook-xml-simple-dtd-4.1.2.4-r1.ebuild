# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-4.1.2.4-r1.ebuild,v 1.1 2004/11/06 14:18:30 usata Exp $

inherit sgml-catalog

MY_P="sdb4124"
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.nwalsh.com/docbook/simple/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"
LICENSE="X11"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"
SLOT="0"
IUSE=""

DEPEND=">=app-arch/unzip-5.41"
RDEPEND=""

sgml-catalog_cat_include "/etc/sgml/xml-simple-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/${P#docbook-}/catalog"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/sgml/docbook/${P#docbook-}
	doins *.dtd *.mod *.css

	newins ${FILESDIR}/${P}.catalog catalog

	insinto /usr/share/sgml/docbook/${P#docbook-}/ent
	doins ent/*.ent

	dodoc README ChangeLog LostLog COPYRIGHT
}
