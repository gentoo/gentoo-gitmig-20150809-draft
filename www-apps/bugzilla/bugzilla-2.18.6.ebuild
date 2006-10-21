# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.18.6.ebuild,v 1.3 2006/10/21 06:25:27 dertobi123 Exp $

inherit webapp

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~ppc64 sparc ~x86"

IUSE="apache2 mysql"

# http://www.bugzilla.org/docs218/html/stepbystep.html to verify dependancies
# updated list of deps: http://www.bugzilla.org/releases/2.18/release-notes.html
RDEPEND="
	mysql? ( >=dev-db/mysql-3.23.41 )
	>=dev-lang/perl-5.6.0
	<=dev-perl/DBD-mysql-3.0002
	>=dev-perl/AppConfig-1.52
	>=virtual/perl-CGI-2.93
	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.36
	>=virtual/perl-File-Spec-0.8.2
	>=dev-perl/Template-Toolkit-2.08
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/Chart-2.3
	>=dev-perl/GD-1.20
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/perl-ldap
	>=dev-perl/PatchReader-0.9.4
	dev-perl/XML-Parser
	apache2? ( >=net-www/apache-2.0 )
	!apache2? ( =net-www/apache-1* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cd ${S}

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die
	for file in `find -type d -printf "%p/* "`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	cp ${FILESDIR}/2.18/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}/2.18
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	webapp_hook_script ${FILESDIR}/2.18/reconfig
	webapp_postinst_txt en ${FILESDIR}/2.18/postinstall-en.txt

	webapp_src_install
}
