# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.20.6.ebuild,v 1.2 2008/05/18 14:40:56 corsair Exp $

inherit webapp depend.apache versionator eutils

MY_PB=$(get_version_component_range 1-2)

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc ~x86"

IUSE="graphviz mysql postgres"

RDEPEND="
	virtual/httpd-cgi
	virtual/mta
	>=dev-lang/perl-5.6.1

	>=dev-perl/AppConfig-1.52
	>=dev-perl/Chart-2.3
	>=dev-perl/DBI-1.38
	>=dev-perl/GD-1.20
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	>=dev-perl/MailTools-1.67
	dev-perl/MIME-tools
	>=dev-perl/PatchReader-0.9.4
	dev-perl/perl-ldap
	>=dev-perl/Template-Toolkit-2.08
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/TimeDate-1.16
	dev-perl/XML-Parser
	>=virtual/perl-CGI-2.93
	>=virtual/perl-File-Spec-0.84
	virtual/perl-File-Temp
	virtual/perl-Storable

	graphviz? ( media-gfx/graphviz )
	mysql? ( <=dev-perl/DBD-mysql-3.0002 )
	postgres? ( >=dev-perl/DBD-Pg-1.43 )
"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean
}

src_install () {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	newins "${FILESDIR}"/${MY_PB}/apache.htaccess .htaccess
	for f in bugzilla.cron.daily bugzilla.cron.tab; do
		doins "${FILESDIR}"/${MY_PB}/${f}
	done

	for f in $(find -type d -printf "%p/* "); do
		webapp_serverowned "${MY_HTDOCSDIR}"/${f}
	done

	webapp_hook_script "${FILESDIR}"/${MY_PB}/reconfig
	webapp_postinst_txt en "${FILESDIR}"/${MY_PB}/postinstall-en.txt
	webapp_src_install
}
