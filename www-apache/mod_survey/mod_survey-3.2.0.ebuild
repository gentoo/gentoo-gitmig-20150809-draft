# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_survey/mod_survey-3.2.0.ebuild,v 1.4 2004/11/30 22:31:30 swegener Exp $

inherit webapp

DESCRIPTION="XML-defined web questionnaires as a plug-in module for Apache"
HOMEPAGE="http://gathering.itm.mh.se/modsurvey/"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="apache2 postgres mysql"
MY_P=${P/mod_survey/modsurvey}
S=${WORKDIR}/${MY_P}
SRC_URI="http://gathering.itm.mh.se/modsurvey/download/${MY_P}.tar.gz"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
		apache2? ( >=net-www/apache-2 >=dev-perl/mod_perl-1.99 )
		!apache2? ( >=net-www/apache-1 >=dev-perl/mod_perl-1.27 )
		postgres? ( >=dev-perl/DBI-1.38	dev-perl/DBD-Pg )
		mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql )
		>=dev-perl/CGI-3.0.0"
LICENSE="GPL-2"

src_unpack() {
	webapp_pkg_setup
	unpack ${A}
	cd ${S}
	sed -i "s|/usr/local/mod_survey/|${D}/usr/lib/mod_survey/|g" installer.pl
}

src_compile() {
	:;
}

src_install() {
	webapp_src_preinst
	dodir /usr/lib/mod_survey
	dodir /var/lib/mod_survey/data

	rm -f docs/LICENSE.txt
	dodoc README.txt docs/*
	rm -rf README.txt docs/

	if use apache2; then
		perl installer.pl < /dev/null > /dev/null 2>&1
		dosed /usr/lib/mod_survey/survey.conf
	else
		echo -e "\n\n\n\n\n\n\nyes\n\n" > out
		perl installer.pl < out > /dev/null 2>&1
		rm -f out
		dosed /usr/lib/mod_survey/survey.conf
	fi
	sed -i "s|\/usr\/lib\/mod_survey\/data\/|\/var\/lib\/mod_survey\/data\/|" ${D}/usr/lib/mod_survey/survey.conf

	# install webroot using webapp.eclass
	# webroot should not go into MY_HTDOCSDIR b/c that throws off Alias
	rm -rf ${D}/usr/lib/mod_survey/webroot ${D}/usr/lib/mod_survey/data
	cp -R webroot ${D}/${MY_HOSTROOTDIR}
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
