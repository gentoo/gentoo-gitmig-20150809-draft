# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mod_survey/mod_survey-3.2.4.ebuild,v 1.2 2007/05/12 04:30:35 chtekk Exp $

inherit webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

DESCRIPTION="XML-defined web questionnaires as a plug-in module using Apache."
HOMEPAGE="http://www.modsurvey.org"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc mysql nls postgres"
MY_PN=${PN/_/}
MY_PV=${PV/_/-}
S=${WORKDIR}/${PN}
SRC_URI="http://www.modsurvey.org/download/tarballs/${MY_PN}-${MY_PV}.tgz
doc? ( http://www.modsurvey.org/download/tarballs/${MY_PN}-docs-${MY_PV}.tgz )"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
		>=net-www/apache-2 >=www-apache/mod_perl-1.99
		postgres? ( >=dev-perl/DBI-1.38 dev-perl/DBD-Pg )
		mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql )
		>=virtual/perl-CGI-3.0.0"
LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup

	# stolen from app-admin/webalizer
	# USE=nls has no real meaning if LINGUAS isn't set
	if use nls && [[ -z "${LINGUAS}" ]] ; then
		ewarn "you must set LINGUAS in /etc/make.conf"
		ewarn "if you want to USE=nls"
		die "please either set LINGUAS or do not use nls"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f docs/LICENSE.txt
	sed -i "s|/usr/local/mod_survey/|${D}/usr/lib/mod_survey/|g" installer.pl
	use doc && unpack ${MY_PN}-docs-${PV}.tgz

	# unfortunatly, this program only allows for one lang, so only the first
	# entry in LINGUAS is used
	if use nls ; then
		local locallang
		if ! grep -q ${LINGUAS:0:2} ${FILESDIR}/language-list.txt ; then
			ewarn "Language ${LINGUAS:0:2} is not supported, using English"
		else
			elog "Using language ${LINGUAS:0:2}"
			locallang="$(grep ^${LINGUAS:0:2} ${FILESDIR}/language-list.txt)"
			sed "s|\$lang = \"en\"|\$lang = \"${locallang}\"|" -i installer.pl
		fi
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
	mv ${D}/usr/lib/mod_survey/survey.conf ${D}/${MY_HOSTROOTDIR}/${PN}

	rm -rf ${D}/usr/lib/mod_survey/webroot ${D}/usr/lib/mod_survey/data
	cp -R webroot/* ${D}/${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
	fowners apache:apache /var/lib/mod_survey/data
}

pkg_postinst(){
	if [[ ${#LINGUAS} -gt 2 ]] && use nls ; then
		ewarn
		ewarn "You have more than one language in LINGUAS"
		ewarn "Due to the limitations of this package, it was built"
		ewarn "only with ${LINGUAS:0:2} support. If this is not what"
		ewarn "you intended, please place the language you desire"
		ewarn "_first_ in the list of LINGUAS in /etc/make.conf"
		ewarn
	fi
	webapp_pkg_postinst
}
