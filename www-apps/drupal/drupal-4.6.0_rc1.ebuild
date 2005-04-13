# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.6.0_rc1.ebuild,v 1.1 2005/04/13 14:20:07 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"
MOD_PV="4.6.0"
MY_PV="${PV/_rc1/-rc}"
S="${WORKDIR}/${PN}-${MOD_PV}"

SRC_URI="http://drupal.org/files/projects/${PN}-${MY_PV}.tar.gz
	!minimal? (
			http://www.drupal.org/files/projects/amazontools-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/article-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/buddylist-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/codefilter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/commentcloser-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/contextlinks-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/customerror-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/daily-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/dba-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ezmlm-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/feedback-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/flexinode-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/fontsize-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/freelinking-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/front-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/hof-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/livediscussions-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/massmailer-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nodewords-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pathauto-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/paypal_framework-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/paypal_subscription-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/quotes-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/rsvp-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/series-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sitemenu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/smartypants-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/statistics_filter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/stock-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_block-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_menu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/textile-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/urlfilter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/webform-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/week-${MOD_PV}.tar.gz
			)"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	unpack ${PN}-${MY_PV}.tar.gz

	cd ${S}/modules
	einfo "Unpacking amazontools"
	unpack amazontools-${MOD_PV}.tar.gz
	einfo "Unpacking article"
	unpack article-${MOD_PV}.tar.gz
	einfo "Unpacking buddylist"
	unpack buddylist-${MOD_PV}.tar.gz
	einfo "Unpacking codefilter"
	unpack codefilter-${MOD_PV}.tar.gz
	einfo "Unpacking commentcloser"
	unpack commentcloser-${MOD_PV}.tar.gz
	einfo "Unpacking contextlinks"
	unpack contextlinks-${MOD_PV}.tar.gz
	einfo "Unpacking customerror"
	unpack customerror-${MOD_PV}.tar.gz
	einfo "Unpacking daily"
	unpack daily-${MOD_PV}.tar.gz
	einfo "Unpacking dba"
	unpack dba-${MOD_PV}.tar.gz
	einfo "Unpacking ezmlm"
	unpack ezmlm-${MOD_PV}.tar.gz
	einfo "Unpacking feedback"
	unpack feedback-${MOD_PV}.tar.gz
	einfo "Unpacking flexinode"
	unpack flexinode-${MOD_PV}.tar.gz
	einfo "Unpacking fontsize"
	unpack fontsize-${MOD_PV}.tar.gz
	einfo "Unpacking freelinking"
	unpack freelinking-${MOD_PV}.tar.gz
	einfo "Unpacking front"
	unpack front-${MOD_PV}.tar.gz
	einfo "Unpacking hof"
	unpack hof-${MOD_PV}.tar.gz
	einfo "Unpacking livediscussions"
	unpack livediscussions-${MOD_PV}.tar.gz
	einfo "Unpacking massmailer"
	unpack massmailer-${MOD_PV}.tar.gz
	einfo "Unpacking nodewords"
	unpack nodewords-${MOD_PV}.tar.gz
	einfo "Unpacking pathauto"
	unpack pathauto-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_framework"
	unpack paypal_framework-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_subscription"
	unpack paypal_subscription-${MOD_PV}.tar.gz
	einfo "Unpacking quotes"
	unpack quotes-${MOD_PV}.tar.gz
	einfo "Unpacking rsvp"
	unpack rsvp-${MOD_PV}.tar.gz
	einfo "Unpacking series"
	unpack series-${MOD_PV}.tar.gz
	einfo "Unpacking sitemenu"
	unpack sitemenu-${MOD_PV}.tar.gz
	einfo "Unpacking smartypants"
	unpack smartypants-${MOD_PV}.tar.gz
	einfo "Unpacking statistics_filter"
	unpack statistics_filter-${MOD_PV}.tar.gz
	einfo "Unpacking stock"
	unpack stock-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_block"
	unpack taxonomy_block-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_menu"
	unpack taxonomy_menu-${MOD_PV}.tar.gz
	einfo "Unpacking textile"
	unpack textile-${MOD_PV}.tar.gz
	einfo "Unpacking urlfilter"
	unpack urlfilter-${MOD_PV}.tar.gz
	einfo "Unpacking webform"
	unpack webform-${MOD_PV}.tar.gz
	einfo "Unpacking week"
	unpack week-${MOD_PV}.tar.gz
}

src_compile() {
	#Default compile hangs!            
	echo "Nothing to compile"
}

src_install() {

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt"

	webapp_src_preinst

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	einfo "Installing docs"
	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	einfo "Copying main files"
	cp -r . ${D}/${MY_HTDOCSDIR}

	# we install the .htaccess file to enable support for clean URLs
	cp .htaccess ${D}/${MY_HTDOCSDIR}

	# create the files upload directory
	mkdir ${D}/${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/files

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for drupal, we *assume* that all .php files need to have CGI/BIN
	# support added

	for x in `find . -name '*.php' -print ` ; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	done

	#All files must be owned by server
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_configfile ${MY_HTDOCSDIR}/sites/default/settings.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

