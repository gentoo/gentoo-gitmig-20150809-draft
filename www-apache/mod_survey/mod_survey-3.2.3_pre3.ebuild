# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_survey/mod_survey-3.2.3_pre3.ebuild,v 1.1 2006/01/19 02:28:42 rl03 Exp $

inherit webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

DESCRIPTION="XML-defined web questionnaires as a plug-in module for Apache"
HOMEPAGE="http://gathering.itm.mh.se/modsurvey/"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="apache2 doc mysql postgres"
MY_PN=${PN/_/}
MY_PV=${PV/_/-}
S=${WORKDIR}/${MY_PN}-${MY_PV}
SRC_URI="http://gathering.itm.mh.se/${MY_PN}/download/test/${MY_PN}-${MY_PV}.tar.gz
	doc? ( http://gathering.itm.mh.se/${MY_PN}/download/test/docs32x.tgz )"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
		apache2? ( >=net-www/apache-2 >=www-apache/mod_perl-1.99 )
		!apache2? ( >=net-www/apache-1 <www-apache/mod_perl-1.99 )
		postgres? ( >=dev-perl/DBI-1.38 dev-perl/DBD-Pg )
		mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql )
		>=perl-core/CGI-3.0.0"
LICENSE="GPL-2"

src_unpack() {
	webapp_pkg_setup
	unpack ${A}
	cd ${S}
	rm -f docs/LICENSE.txt
	sed -i "s|/usr/local/mod_survey/|${D}/usr/lib/mod_survey/|g" installer.pl
	use doc && unpack docs32x.tgz

	if ! use apache2; then
		sed "s|\$isa2 = \"Off\"|\$isa2 = \"On\"|" -i installer.pl
	fi
}

src_install() {
	webapp_src_preinst

	dodir /usr/lib/mod_survey
	dodir /var/lib/mod_survey/data
	dodir ${MY_HOSTROOTDIR}/${PN}

	dodoc README.txt docs/*

	perl installer.pl < /dev/null > /dev/null 2>&1
	dosed /usr/lib/mod_survey/survey.conf
	sed -i "s|/usr/lib/mod_survey/data/|/var/lib/mod_survey/data/|" ${D}/usr/lib/mod_survey/survey.conf

	# install webroot using webapp.eclass
	# webroot should not go into MY_HTDOCSDIR b/c that throws off Alias
	rm -rf ${D}/usr/lib/mod_survey/webroot ${D}/usr/lib/mod_survey/data
	cp -R webroot/* ${D}/${MY_HOSTROOTDIR}/${PN}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
	fowners apache:apache /var/lib/mod_survey/data
}
