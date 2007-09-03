# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-3.0.1.ebuild,v 1.1 2007/09/03 07:20:54 wrobel Exp $

inherit webapp depend.apache versionator eutils

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz
	linguas_de? ( http://ganderbay.net/dl/germzilla-${PV}-1.utf-8.tar.gz  )"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="modperl extras graphviz mysql postgres linguas_de"

RDEPEND="
	>=dev-lang/perl-5.8.0
	mysql? ( >=dev-perl/DBD-mysql-3.0007 )
	postgres? ( >=dev-perl/DBD-Pg-1.45 )
	graphviz? ( media-gfx/graphviz )
	>=virtual/perl-CGI-2.93
	modperl? (
		>=virtual/perl-CGI-3.11
		=www-apache/mod_perl-2*
		>=dev-perl/Apache-DBI-0.96
	)

	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.41
	>=virtual/perl-File-Spec-0.84
	>=dev-perl/Template-Toolkit-2.13
	>=virtual/perl-MIME-Base64-3.01
	dev-perl/MIME-tools
	>=dev-perl/Email-Send-2.00
	dev-perl/Email-MIME-Modifier

	extras? (
	>=dev-perl/GD-1.20
	dev-perl/Template-GD
	>=dev-perl/Chart-2.3
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/XML-Twig
	dev-perl/libwww-perl
	>=dev-perl/PatchReader-0.9.4
	dev-perl/perl-ldap
	dev-perl/SOAP-Lite
	>=dev-perl/HTML-Parser-3.40
	dev-perl/HTML-Scrubber
	dev-perl/Email-MIME-Attachment-Stripper
	dev-perl/Email-Reply
	)
"

want_apache

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

	if use linguas_de ; then
		mv de ${P}/template
		elog "Installing German translation pack"
		elog "Be sure to read http://wiki.ganderbay.net/wde/Germzilla-Installation"
		elog "for installation instructions"
	fi

	# remove CVS directories
	cd ${S}
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	webapp_hook_script ${FILESDIR}/$(get_version_component_range 1-2)/reconfig
	webapp_postinst_txt en ${FILESDIR}/$(get_version_component_range 1-2)/postinstall-en.txt
	webapp_src_install

	# bug #124282
	chmod -R +x ${D}/${MY_HTDOCSDIR}/*.cgi
}
