# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.5.2.ebuild,v 1.1 2005/02/01 03:12:16 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"
MOD_PV="4.5.0"
S="${WORKDIR}/${P}"

SRC_URI="http://drupal.org/files/projects/${P}.tar.gz
	!minimal? ( http://drupal.org/files/projects/affiliate-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/api-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/article-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/atom-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/attached_node-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/attachment-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/automember-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/banner-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/bbcode-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/bookmarks-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/buddylist-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/captcha-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/chatbox-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/codefilter-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/collimator-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/commentcloser-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/contextlinks-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/csvfilter-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/postcount_rank-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/daily-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/dba-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/dkosfilter-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/ecommerce-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/event-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/feature-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/feedback-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/filemanager-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/filestore2-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/flexinode-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/foaf-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/forms-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/form_mail-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/fscache-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/glossary-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/htmlarea-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/htmlcorrector-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/htmltidy-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/image-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/image_filter-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/img_assist-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/inline-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/im-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/jsdomenu-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/listhandler-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/mail-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/mailalias-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/mailhandler-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/marksmarty-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/members-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/mypage-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/news_page-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/nmoderation-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/node_privacy_byrole-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/typecat-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/node_import-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/notify-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/optin-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/og-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/over_text-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/paypal_framework-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/paypal_tipjar-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/periodical-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/poormanscron-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/postcard-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/print-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/privatemsg-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/quickpost-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/quote-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/quotes-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/recipe-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/relatedlinks-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/role_to_file-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/scheduler-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/simpletest-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/site_map-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/smileys-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/spam-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/subscriptions-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/summary-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/survey-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/sxip-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/syndication-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_access-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_browser-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_context-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_dhtml-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_html-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_image-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/taxonomy_menu-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/term_statistics-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/textile-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/themedev-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/title-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/trackback-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/translation-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/trip_search-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/urlfilter-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/userposts-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/validation-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/variable-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/weather-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/webform-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/weblink-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/webserver_auth-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/workspace-${MOD_PV}.tar.gz

				http://drupal.org/files/projects/adc-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/box_grey_smarty-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/box_grey-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/goofy-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/interlaced-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/kubrick-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/marvin_2k_phptemplate-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/persian-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/sunflower-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/phptemplate-${MOD_PV}.tar.gz
				http://drupal.org/files/projects/smarty-${MOD_PV}.tar.gz
				
				http://drupal.org/files/projects/zh-hans-${MOD_PV}.tar.gz
				)"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	tar xfz ${DISTDIR}/${P}.tar.gz

	cd ${S}/modules
	tar xfz  ${DISTDIR}/affiliate-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/api-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/article-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/atom-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/attached_node-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/attachment-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/automember-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/banner-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/bbcode-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/bookmarks-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/buddylist-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/captcha-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/chatbox-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/codefilter-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/collimator-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/commentcloser-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/contextlinks-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/csvfilter-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/postcount_rank-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/daily-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/dba-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/dkosfilter-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/ecommerce-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/event-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/feature-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/feedback-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/filemanager-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/filestore2-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/flexinode-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/foaf-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/forms-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/form_mail-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/fscache-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/glossary-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/htmlarea-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/htmlcorrector-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/htmltidy-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/image-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/image_filter-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/img_assist-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/inline-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/im-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/jsdomenu-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/listhandler-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/mail-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/mailalias-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/mailhandler-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/marksmarty-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/members-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/mypage-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/news_page-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/nmoderation-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/node_privacy_byrole-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/typecat-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/node_import-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/notify-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/optin-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/og-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/over_text-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/paypal_framework-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/paypal_tipjar-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/periodical-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/poormanscron-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/postcard-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/print-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/privatemsg-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/quickpost-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/quote-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/quotes-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/recipe-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/relatedlinks-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/role_to_file-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/scheduler-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/simpletest-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/site_map-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/smileys-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/spam-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/subscriptions-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/summary-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/survey-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/sxip-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/syndication-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_access-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_browser-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_context-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_dhtml-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_html-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_image-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/taxonomy_menu-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/term_statistics-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/textile-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/themedev-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/title-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/trackback-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/translation-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/trip_search-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/urlfilter-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/userposts-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/validation-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/variable-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/weather-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/webform-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/weblink-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/webserver_auth-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/workspace-${MOD_PV}.tar.gz

	cd ${S}/themes
	tar xfz  ${DISTDIR}/adc-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/box_grey_smarty-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/box_grey-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/goofy-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/interlaced-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/kubrick-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/marvin_2k_phptemplate-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/persian-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/sunflower-${MOD_PV}.tar.gz

	cd ${S}/themes/engines
	tar xfz  ${DISTDIR}/phptemplate-${MOD_PV}.tar.gz
	tar xfz  ${DISTDIR}/smarty-${MOD_PV}.tar.gz

	cd ${S}
	tar xfz  ${DISTDIR}/zh-hans-${MOD_PV}.tar.gz
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

	webapp_configfile ${MY_HTDOCSDIR}/includes/conf.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

