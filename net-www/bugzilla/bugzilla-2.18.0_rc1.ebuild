# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/bugzilla/bugzilla-2.18.0_rc1.ebuild,v 1.3 2004/07/19 10:02:59 mr_bones_ Exp $

inherit webapp
MY_P=${P/.0_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${MY_P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~x86 ~ppc ~sparc"

IUSE="apache2"

# See http://www.bugzilla.org/docs216/html/stepbystep.html to verify dependancies
DEPEND="$DEPEND"
RDEPEND=">=dev-db/mysql-3.22.5
	>=dev-lang/perl-5.01
	dev-perl/Template-Toolkit
	>=dev-perl/AppConfig-1.52
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/File-Spec-0.8.2
	>=dev-perl/DBD-mysql-1.2209
	>=dev-perl/DBI-1.13
	dev-perl/TimeDate
	>=dev-perl/CGI-2.88
	>=dev-perl/GD-1.19
	dev-perl/GDGraph
	>=dev-perl/Chart-2.3
	dev-perl/XML-Parser
	dev-perl/PatchReader
	dev-perl/MIME-tools
	apache2? ( >=net-www/apache-2 )
	!apache2? ( =net-www/apache-1* )"

# removed deps:  dev-perl/Data-Dumper

src_install () {
	webapp_src_preinst

	cd ${S}

	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die
	for file in `find -type d -printf "%p/* "`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	cp ${FILESDIR}/${PVR}/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	FILE="bugzilla.cron.daily bugzilla.cron.tab bz.cfg.templ firstcheck.sh cronset.sh"
	for file in ${FILE}; do
		cp ${FILESDIR}/${file} ${D}/${MY_HTDOCSDIR}
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	# add the reconfigure hook
	webapp_hook_script ${FILESDIR}/${PVR}/reconfig

	webapp_src_install
}
