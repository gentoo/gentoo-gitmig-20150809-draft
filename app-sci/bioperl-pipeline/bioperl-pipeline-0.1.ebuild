# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl-pipeline/bioperl-pipeline-0.1.ebuild,v 1.1 2003/12/16 00:35:07 sediener Exp $

inherit perl-module
CATEGORY="app-sci"

DESCRIPTION="Collection of tools for bioinformatics, genomics and life science research : Biopipe "
HOMEPAGE="http://www.biopipe.org/"
SRC_URI="mirror://gentoo/$P.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	dev-db/mysql
	>=app-sci/bioperl-1.2.3
	>=app-sci/bioperl-run-1.2.2
	dev-perl/XML-SimpleObject
	dev-perl/XML-Parser
	dev-perl/Data-ShowTable"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	# there's a test to run for BioGFFDB if using mysql
	perl-module_src_compile || die "compile failed"
	# make test
	##	perl-module_src_test || die "src test failed"
	# tests will fail unless mysq root user has no password
}

src_install() {
	mydoc="AUTHORS README LICENSE INSTALL FAQ database_schema.doc database_tables.txt"
	perl-module_src_install

	# bioperl scripts and examples
	einfo "Adding bioperl-pipeline scripts, sql and xml directories to /usr/share/${PF}..."
	dodir /usr/share/${PF}/scripts
	cd ${S}/scripts/
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/scripts; tar xf -)
	dodir /usr/share/${PF}/sql
	cd ${S}/sql/
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/sql; tar xf -)
	dodir /usr/share/${PF}/xml
	cd ${S}/xml/
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/xml; tar xf -)
	dodir /usr/share/doc/${PF}/
	cd ${S}/doc/
	tar cf - ./ | ( cd ${D}/usr/share/doc/${PF}; tar xf -)
	cd ${S}

}
