# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-4.1.2.4-r1.ebuild,v 1.2 2004/11/08 14:48:38 vapier Exp $

inherit sgml-catalog

MY_P="sdb4124"
DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.nwalsh.com/docbook/simple/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
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
