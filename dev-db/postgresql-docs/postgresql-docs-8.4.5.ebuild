# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-docs/postgresql-docs-8.4.5.ebuild,v 1.1 2010/10/06 14:57:39 patrick Exp $

inherit versionator

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"

# Nothing to test here per 232157
RESTRICT="test"

DESCRIPTION="PostgreSQL documentation"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2"
LICENSE="POSTGRESQL"
SLOT="$(get_version_component_range 1-2)"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/postgresql-${PV}"

src_compile() {
	:
}

src_install() {
	dodir /usr/share/doc/${PF}/html
	tar -zxf "${S}/doc/postgres.tar.gz" -C "${D}/usr/share/doc/${PF}/html"
	fowners root:0 -R /usr/share/doc/${PF}/html
	cd "${S}/doc"
	docinto FAQ_html
	#dodoc src/FAQ/* # no longer there?
	docinto sgml
	dodoc src/sgml/*.{sgml,dsl}
	docinto sgml/ref
	dodoc src/sgml/ref/*.sgml
	docinto
	dodoc TODO

	dodir /etc/eselect/postgresql/slots/${SLOT}
	{
		echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\""
	} >"${D}/etc/eselect/postgresql/slots/${SLOT}/docs"
}
