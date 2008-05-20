# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.22.4.ebuild,v 1.5 2008/05/20 16:35:04 dertobi123 Exp $

inherit webapp depend.apache versionator eutils

MY_PB=$(get_version_component_range 1-2)

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ia64 ppc ppc64 sparc x86"

IUSE="extras graphviz mysql postgres"

RDEPEND="
	virtual/httpd-cgi
	>=dev-lang/perl-5.6.1

	>=dev-perl/AppConfig-1.52
	>=dev-perl/DBI-1.38
	>=dev-perl/MailTools-1.67
	dev-perl/MIME-tools
	>=dev-perl/Template-Toolkit-2.13
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/TimeDate-1.16
	>=virtual/perl-CGI-2.93
	>=virtual/perl-File-Spec-0.84
	virtual/perl-File-Temp
	>=virtual/perl-MIME-Base64-3.01
	virtual/perl-Storable

	extras? (
		>=dev-perl/Chart-2.3
		>=dev-perl/GD-1.20
		dev-perl/GDGraph
		dev-perl/GDTextUtil
		dev-perl/HTML-Scrubber
		>=dev-perl/PatchReader-0.9.4
		dev-perl/perl-ldap
		dev-perl/Template-GD
		dev-perl/XML-Twig
		dev-util/patchutils
	)

	graphviz? ( media-gfx/graphviz )
	mysql? ( >=dev-perl/DBD-mysql-3.0007 )
	postgres? ( >=dev-perl/DBD-Pg-1.45 )
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

	webapp_hook_script "${FILESDIR}"/${MY_PB}/reconfig
	webapp_postinst_txt en "${FILESDIR}"/${MY_PB}/postinstall-en.txt
	webapp_src_install

	# bug #124282
	chmod +x "${D}${MY_HTDOCSDIR}"/*.cgi
}
