# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl-pipeline/bioperl-pipeline-0.1.ebuild,v 1.6 2004/08/03 11:48:24 dholm Exp $

inherit perl-module
CATEGORY="app-sci"

DESCRIPTION="Collection of tools for bioinformatics, genomics and life science research : Biopipe "
HOMEPAGE="http://www.biopipe.org/"
SRC_URI="mirror://gentoo/$P.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="
	dev-db/mysql
	>=app-sci/ncbi-tools-20031103
	>=app-sci/bioperl-1.2.3
	>=app-sci/bioperl-run-1.2.2
	dev-perl/XML-SimpleObject
	dev-perl/XML-Parser
	dev-perl/Data-ShowTable"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	# there's a test to run for BioGFFDB if using mysql
	perl-module_src_compile || die "compile failed"
	# make test
	##	perl-module_src_test || die "src test failed"
	ewarn " "
	ewarn "Tests skipped since they will fail unless"
	ewarn "mysql root user has no password"
	ewarn " "
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

pkg_postinst() {
	einfo " "
	einfo "You will need to modify Bio/Pipeline/PipeConf.pm "
	einfo "with mysql user and batch job software information"
	einfo "Read the docs in /usr/share/docs/${PF} "
	einfo "for more information"
	einfo " "
}
