# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-3.2.ebuild,v 1.1 2008/12/07 07:40:22 wrobel Exp $

inherit webapp depend.apache versionator eutils

MY_PB=3.0

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz
	linguas_de? ( http://ganderbay.net/dl/germzilla-${PV}-1.utf-8.tar.gz )"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="modperl extras graphviz mysql postgres linguas_de"

RDEPEND="
	virtual/httpd-cgi
	>=dev-lang/perl-5.8.0

	>=dev-perl/DBI-1.41
	>=dev-perl/Email-MIME-1.861
	>=dev-perl/Email-MIME-Modifier-1.442
	>=dev-perl/Email-Send-2.16
	>=dev-perl/MIME-tools-5.406
	>=dev-perl/Template-Toolkit-2.15
	>=dev-perl/TimeDate-1.16
	>=virtual/perl-CGI-3.21
	>=virtual/perl-File-Spec-0.84
	>=virtual/perl-MIME-Base64-3.01

	mysql? ( >=dev-perl/DBD-mysql-4.00 )
	postgres? ( >=dev-perl/DBD-Pg-1.45 )
	graphviz? ( media-gfx/graphviz )

	modperl? (
		>=dev-perl/Apache-DBI-0.96
		>=virtual/perl-CGI-3.21
		=www-apache/mod_perl-2*
	)

	extras? (
		dev-perl/Authen-SASL
		>=dev-perl/Chart-1.0
		dev-perl/Email-MIME-Attachment-Stripper
		dev-perl/Email-Reply
		>=dev-perl/GD-1.20
		dev-perl/GDGraph
		dev-perl/GDTextUtil
		>=dev-perl/HTML-Parser-3.40
		dev-perl/HTML-Scrubber
		dev-perl/libwww-perl
		>=dev-perl/PatchReader-0.9.4
		dev-perl/perl-ldap
		dev-perl/SOAP-Lite
		dev-perl/Template-GD
		dev-perl/XML-Twig
	)
"

want_apache modperl

pkg_setup() {
	webapp_pkg_setup

	if use extras ; then
		if ! has_version media-gfx/imagemagick || ! built_with_use media-gfx/imagemagick perl ; then
			elog "Consider installing media-gfx/imagemagick with USE=\"perl\""
			elog "to convert BMP attachments to PNG"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean

	if use linguas_de ; then
		mv ../de template/
		elog "Installing German translation pack"
		elog "Be sure to read http://wiki.ganderbay.net/wde/Germzilla-Installation"
		elog "for installation instructions"
	fi
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
}
