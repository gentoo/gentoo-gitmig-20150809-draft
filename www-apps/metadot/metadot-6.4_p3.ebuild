# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/metadot/metadot-6.4_p3.ebuild,v 1.1 2005/08/22 20:25:29 rl03 Exp $

inherit webapp
MY_P="${PN}${PV/_p/r}"
S=${WORKDIR}/${PN}

IUSE=""

DESCRIPTION="Metadot is a CMS with file, page and link management, and collaboration features."
HOMEPAGE="http://www.metadot.com"
SRC_URI="http://download.metadot.com/${MY_P}.tar.gz"

KEYWORDS="~x86"

DEPEND=""
RDEPEND=">=dev-db/mysql-3.23
	>=net-www/apache-1.3.6
	>=dev-lang/perl-5.6
	>=www-apache/mod_perl-1.21
	dev-perl/DBI
	>=dev-perl/DBD-mysql-2.1027
	dev-perl/Apache-DBI
	>=dev-perl/AppConfig-1.55
	>=perl-core/ExtUtils-MakeMaker-6.05
	>=dev-perl/XML-RSS-1.02
	>=perl-core/Storable-2.07
	dev-perl/perl-ldap
	>=dev-perl/Log-Agent-0.304
	dev-perl/Mail-POP3Client
	>=dev-perl/IO-stringy-2.108
	dev-perl/MailTools
	dev-perl/MIME-tools
	>=dev-perl/Msql-Mysql-modules-1.1835
	>=dev-perl/Unicode-String-2.07
	>=dev-perl/Spreadsheet-WriteExcel-0.41
	>=dev-perl/Date-Calc-5.3
	>=dev-perl/ImageSize-2.991
	>=dev-perl/Template-Toolkit-2.09
	>=perl-core/Time-HiRes-1.48
	>=perl-core/Test-Harness-2.28
	>=dev-perl/Test-Manifest-0.91
	>=perl-core/Test-Simple-0.47
	>=dev-perl/Lingua-EN-NameParse-1.18
	>=dev-perl/Number-Format-1.45
	>=dev-perl/XML-Simple-2.08
	dev-perl/XML-Dumper
	dev-perl/Archive-Zip
	dev-perl/Text-CSV_XS
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst

	dodoc CHANGELOG README
	cp -R [[:lower:]][[:lower:]]* ${D}/${MY_HTDOCSDIR}

	cp ${FILESDIR}/${PN}.conf ${D}/${MY_SERVERCONFIGDIR}

	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/sitedata/public

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PVR}.txt
	webapp_hook_script ${FILESDIR}/reconfig-${PVR}
	webapp_src_install
}
