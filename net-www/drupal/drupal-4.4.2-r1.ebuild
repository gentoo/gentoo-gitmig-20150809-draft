# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/drupal/drupal-4.4.2-r1.ebuild,v 1.1 2004/07/15 18:48:29 stuart Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"

SRC_URI="http://drupal.org/drupal/${P}.tgz
	!minimal? ( http://drupal.org/files/projects/article-4.4.0.tar.gz
				http://drupal.org/files/projects/artist-4.4.0.tar.gz
				http://drupal.org/files/projects/atom-4.4.0.tar.gz
				http://drupal.org/files/projects/banner-4.4.0.tar.gz
				http://drupal.org/files/projects/bbcode-4.4.0.tar.gz
				http://drupal.org/files/projects/blogadmin-4.4.0.tar.gz
				http://drupal.org/files/projects/bookreview-4.4.0.tar.gz
				http://drupal.org/files/projects/bookmarks-4.4.0.tar.gz
				http://drupal.org/files/projects/buddylist-4.4.0.tar.gz
				http://drupal.org/files/projects/chatbox-4.4.0.tar.gz
				http://drupal.org/files/projects/codefilter-4.4.0.tar.gz
				http://drupal.org/files/projects/commentrss-4.4.0.tar.gz
				http://drupal.org/files/projects/contextlinks-4.4.0.tar.gz
				http://drupal.org/files/projects/csvfilter-4.4.0.tar.gz
				http://drupal.org/files/projects/dba-4.4.0.tar.gz
				http://drupal.org/files/projects/devel-4.4.0.tar.gz
				http://drupal.org/files/projects/emailpage-4.4.0.tar.gz
				http://drupal.org/files/projects/event-4.4.0.tar.gz
				http://drupal.org/files/projects/filestore-4.4.0.tar.gz
				http://drupal.org/files/projects/filtercache-4.4.0.tar.gz
				http://drupal.org/files/projects/fixentities-4.4.0.tar.gz
				http://drupal.org/files/projects/flexinode-4.4.0.tar.gz
				http://drupal.org/files/projects/form_mail-4.4.0.tar.gz
				http://drupal.org/files/projects/glossary-4.4.0.tar.gz
				http://drupal.org/files/projects/groups-4.4.0.tar.gz
				http://drupal.org/files/projects/htmlarea-4.4.0.tar.gz
				http://drupal.org/files/projects/htmlcorrector-4.4.0.tar.gz
				http://drupal.org/files/projects/htmltidy-4.4.0.tar.gz
				http://drupal.org/files/projects/image-4.4.0.tar.gz
				http://drupal.org/files/projects/img_assist-4.4.0.tar.gz
				http://drupal.org/files/projects/importpage-4.4.0.tar.gz
				http://drupal.org/files/projects/i18n-4.4.0.tar.gz
				http://drupal.org/files/projects/jsdomenu-4.4.0.tar.gz
				http://drupal.org/files/projects/lanparty-4.4.0.tar.gz
				http://drupal.org/files/projects/link2page-4.4.0.tar.gz
				http://drupal.org/files/projects/listhandler-4.4.0.tar.gz
				http://drupal.org/files/projects/locale-4.4.0.tar.gz
				http://drupal.org/files/projects/localegettext-4.4.0.tar.gz
				http://drupal.org/files/projects/mailalias-4.4.0.tar.gz
				http://drupal.org/files/projects/mailhandler-4.4.0.tar.gz
				http://drupal.org/files/projects/menus-4.4.0.tar.gz
				http://drupal.org/files/projects/navigation-4.4.0.tar.gz
				http://drupal.org/files/projects/nicelinks-4.4.0.tar.gz
				http://drupal.org/files/projects/nodewords-4.4.0.tar.gz
				http://drupal.org/files/projects/node_image-4.4.0.tar.gz
				http://drupal.org/files/projects/node_import-4.4.0.tar.gz
				http://drupal.org/files/projects/notify-4.4.0.tar.gz
				http://drupal.org/files/projects/pdfview-4.4.0.tar.gz
				http://drupal.org/files/projects/poormanscron-4.4.0.tar.gz
				http://drupal.org/files/projects/printpage-4.4.0.tar.gz
				http://drupal.org/files/projects/privatemsg-4.4.0.tar.gz
				http://drupal.org/files/projects/project-4.4.0.tar.gz
				http://drupal.org/files/projects/quote-4.4.0.tar.gz
				http://drupal.org/files/projects/quotes-4.4.0.tar.gz
				http://drupal.org/files/projects/recipe-4.4.0.tar.gz
				http://drupal.org/files/projects/remindme-4.4.0.tar.gz
				http://drupal.org/files/projects/scheduler-4.4.0.tar.gz
				http://drupal.org/files/projects/series-4.4.0.tar.gz
				http://drupal.org/files/projects/smileys-4.4.0.tar.gz
				http://drupal.org/files/projects/spellcheck-4.4.0.tar.gz
				http://drupal.org/files/projects/subscriptions-4.4.0.tar.gz
				http://drupal.org/files/projects/summary-4.4.0.tar.gz
				http://drupal.org/files/projects/syndication-4.4.0.tar.gz
				http://drupal.org/files/projects/taxonomy_browser-4.4.0.tar.gz
				http://drupal.org/files/projects/taxonomy_context-4.4.0.tar.gz
				http://drupal.org/files/projects/taxonomy_image-4.4.0.tar.gz
				http://drupal.org/files/projects/taxonomy_menu-4.4.0.tar.gz
				http://drupal.org/files/projects/term_access-4.4.0.tar.gz
				http://drupal.org/files/projects/textile-4.4.0.tar.gz
				http://drupal.org/files/projects/themedev-4.4.0.tar.gz
				http://drupal.org/files/projects/trackback-4.4.0.tar.gz
				http://drupal.org/files/projects/trip_search-4.4.0.tar.gz
				http://drupal.org/files/projects/upload-4.4.0.tar.gz
				http://drupal.org/files/projects/urlfilter-4.4.0.tar.gz
				http://drupal.org/files/projects/variable-4.4.0.tar.gz
				http://drupal.org/files/projects/vocabulary_list-4.4.0.tar.gz
				http://drupal.org/files/projects/weather-4.4.0.tar.gz
				http://drupal.org/files/projects/webform-4.4.0.tar.gz
				http://drupal.org/files/projects/weblink-4.4.0.tar.gz
				http://drupal.org/files/projects/wiki-4.4.0.tar.gz
				http://drupal.org/files/projects/ystock-4.4.0.tar.gz
				http://drupal.org/files/projects/gworks-4.4.0.tar.gz
				http://drupal.org/files/projects/interlaced-4.4.0.tar.gz
				http://drupal.org/files/projects/marvin_2k-4.4.0.tar.gz
				http://drupal.org/files/projects/phptemplate-4.4.0.tar.gz
				)"

LICENSE="GPL-2"
KEYWORDS="-x86"

DEPEND="virtual/php"

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

	webapp_configfile ${MY_HTDOCSDIR}/includes/conf.php

	webapp_postinst_txt en ${FILESDIR}/${PV}/postinstall-en.txt

	webapp_src_install
}

