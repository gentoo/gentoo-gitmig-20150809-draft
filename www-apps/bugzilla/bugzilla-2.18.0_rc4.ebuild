# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.18.0_rc4.ebuild,v 1.4 2005/03/29 15:25:49 mcummings Exp $

inherit eutils webapp

MY_PV=${PV/.0_rc4/}rc3
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${MY_P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~x86 ppc ~sparc ~ppc64"

IUSE="apache2"

# See http://www.bugzilla.org/docs216/html/stepbystep.html to verify dependancies
# updated list of deps: http://www.bugzilla.org/releases/2.18/release-notes.html
# removed deps:	dev-perl/MIME-tools
RDEPEND=">=dev-db/mysql-3.23.41
	>=dev-lang/perl-5.6.0
	>=dev-perl/AppConfig-1.52
	>=dev-perl/CGI-2.93
	>=dev-perl/TimeDate-1.11
	>=dev-perl/DBI-1.36
	>=dev-perl/DBD-mysql-2.1010
	>=dev-perl/File-Spec-0.8.2
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

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/CAN-2004-1061.patch
}

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
