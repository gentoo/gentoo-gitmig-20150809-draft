# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-3.2.10.ebuild,v 1.3 2011/01/26 19:48:04 fauli Exp $

EAPI="2"

inherit webapp depend.apache versionator eutils

MY_PB=3.0

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"

IUSE="modperl extras graphviz mysql postgres"

RDEPEND="
	virtual/httpd-cgi
	>=dev-lang/perl-5.8.8

	>=dev-perl/DBI-1.601
	>=dev-perl/Email-MIME-1.900
	>=dev-perl/Email-MIME-Encodings-1.313
	>=dev-perl/Email-Send-2.190
	>=dev-perl/MIME-tools-5.427
	>=dev-perl/Template-Toolkit-2.19
	>=dev-perl/TimeDate-1.16
	>=virtual/perl-CGI-3.29
	>=virtual/perl-File-Spec-3.27.01
	>=virtual/perl-MIME-Base64-3.07

	mysql? ( >=dev-perl/DBD-mysql-4.00.5 )
	postgres? ( >=dev-perl/DBD-Pg-1.49 )
	graphviz? ( media-gfx/graphviz )

	modperl? (
		>=dev-perl/Apache-DBI-1.06
		www-apache/mod_perl:1
	)

	extras? (
		dev-perl/Authen-SASL
		>=dev-perl/Chart-2.4.1
		dev-perl/Email-MIME-Attachment-Stripper
		dev-perl/Email-Reply
		>=dev-perl/GD-2.35
		dev-perl/GDGraph
		dev-perl/GDTextUtil
		>=dev-perl/HTML-Parser-3.60
		dev-perl/HTML-Scrubber
		dev-perl/libwww-perl
		>=dev-perl/PatchReader-0.9.5
		dev-perl/perl-ldap
		dev-perl/SOAP-Lite
		dev-perl/Template-GD
		dev-perl/XML-Twig
		media-gfx/imagemagick[perl]
	)
"

want_apache modperl

pkg_setup() {
	depend.apache_pkg_setup modperl
	webapp_pkg_setup
}

src_prepare() {
	ecvs_clean
}

src_install () {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	for f in bugzilla.cron.daily bugzilla.cron.tab; do
		doins "${FILESDIR}"/${MY_PB}/${f}
	done

	webapp_hook_script "${FILESDIR}"/${MY_PB}/reconfig
	webapp_postinst_txt en "${FILESDIR}"/${MY_PB}/postinstall-en.txt
	webapp_src_install

	# bug #124282
	chmod +x "${D}${MY_HTDOCSDIR}"/*.cgi
	# configuration must be executable
	chmod u+x "${D}${MY_HTDOCSDIR}"/checksetup.pl
}
