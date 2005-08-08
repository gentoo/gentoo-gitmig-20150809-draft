# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.20_rc2.ebuild,v 1.1 2005/08/08 21:32:40 rl03 Exp $

inherit webapp eutils

MY_P=${PN}-${PV/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${MY_P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="apache2 postgres graphviz"

RDEPEND="
	>=dev-lang/perl-5.6.1
	postgres? ( >=dev-db/postgresql-7.3 >=dev-perl/DBD-Pg-1.43 )
	!postgres? ( >=dev-db/mysql-3.23.41	>=dev-perl/DBD-mysql-2.9003 )
	apache2? ( >=net-www/apache-2.0 )
	!apache2? ( =net-www/apache-1* )
	graphviz? ( media-gfx/graphviz )
	>=dev-perl/AppConfig-1.52
	>=perl-core/CGI-2.93
	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.38
	>=perl-core/File-Spec-0.82
	perl-core/File-Temp
	>=dev-perl/Template-Toolkit-2.08
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/MailTools-1.67
	perl-core/Storable
	>=dev-perl/GD-1.20
	>=dev-perl/Chart-2.3
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/XML-Parser
	>=dev-perl/PatchReader-0.9.4
	dev-perl/MIME-tools
	dev-perl/perl-ldap
	virtual/mta
"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die
	for file in `find -type d -printf "%p/* "`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	cp ${FILESDIR}/2.20_rc1/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}/2.20_rc1
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	webapp_hook_script ${FILESDIR}/2.20_rc1/reconfig
	webapp_src_install
}
