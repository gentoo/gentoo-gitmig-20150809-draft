# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.6.0.ebuild,v 1.2 2005/05/02 12:31:41 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"
S="${WORKDIR}/${P}"

SRC_URI="http://drupal.org/files/projects/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz

	if ! use minimal ; then
		cd ${S}/modules
		einfo "Unpacking album"
		wget -q http://www.drupal.org/files/projects/album-4.6.0.tar.gz
		tar xfz album-4.6.0.tar.gz

		einfo "Unpacking amazontools"
		wget -q http://www.drupal.org/files/projects/amazontools-4.6.0.tar.gz
		tar xfz amazontools-4.6.0.tar.gz

		einfo "Unpacking amazonsearch"
		wget -q http://www.drupal.org/files/projects/amazonsearch-4.6.0.tar.gz
		tar xfz amazonsearch-4.6.0.tar.gz

		einfo "Unpacking article"
		wget -q http://www.drupal.org/files/projects/article-4.6.0.tar.gz
		tar xfz article-4.6.0.tar.gz

		einfo "Unpacking attachment"
		wget -q http://www.drupal.org/files/projects/attachment-4.6.0.tar.gz
		tar xfz attachment-4.6.0.tar.gz

		einfo "Unpacking bookreview"
		wget -q http://www.drupal.org/files/projects/bookreview-4.6.0.tar.gz
		tar xfz bookreview-4.6.0.tar.gz

		einfo "Unpacking bookmarks"
		wget -q http://www.drupal.org/files/projects/bookmarks-4.6.0.tar.gz
		tar xfz bookmarks-4.6.0.tar.gz

		einfo "Unpacking buddylist"
		wget -q http://www.drupal.org/files/projects/buddylist-4.6.0.tar.gz
		tar xfz buddylist-4.6.0.tar.gz

		einfo "Unpacking chatbox"
		wget -q http://www.drupal.org/files/projects/chatbox-4.6.0.tar.gz
		tar xfz chatbox-4.6.0.tar.gz

		einfo "Unpacking codefilter"
		wget -q http://www.drupal.org/files/projects/codefilter-4.6.0.tar.gz
		tar xfz codefilter-4.6.0.tar.gz

		einfo "Unpacking commentcloser"
		wget -q http://www.drupal.org/files/projects/commentcloser-4.6.0.tar.gz
		tar xfz commentcloser-4.6.0.tar.gz

		einfo "Unpacking contact_dir"
		wget -q http://www.drupal.org/files/projects/contact_dir-4.6.0.tar.gz
		tar xfz contact_dir-4.6.0.tar.gz

		einfo "Unpacking contextlinks"
		wget -q http://www.drupal.org/files/projects/contextlinks-4.6.0.tar.gz
		tar xfz contextlinks-4.6.0.tar.gz

		einfo "Unpacking customerror"
		wget -q http://www.drupal.org/files/projects/customerror-4.6.0.tar.gz
		tar xfz customerror-4.6.0.tar.gz

		einfo "Unpacking daily"
		wget -q http://www.drupal.org/files/projects/daily-4.6.0.tar.gz
		tar xfz daily-4.6.0.tar.gz

		einfo "Unpacking dba"
		wget -q http://www.drupal.org/files/projects/dba-4.6.0.tar.gz
		tar xfz dba-4.6.0.tar.gz

		einfo "Unpacking diff"
		wget -q http://www.drupal.org/files/projects/diff-4.6.0.tar.gz
		tar xfz diff-4.6.0.tar.gz

		einfo "Unpacking download_counter"
		wget -q http://www.drupal.org/files/projects/download_counter-4.6.0.tar.gz
		tar xfz download_counter-4.6.0.tar.gz

		einfo "Unpacking event"
		wget -q http://www.drupal.org/files/projects/event-4.6.0.tar.gz
		tar xfz event-4.6.0.tar.gz

		einfo "Unpacking excerpt"
		wget -q http://www.drupal.org/files/projects/excerpt-4.6.0.tar.gz
		tar xfz excerpt-4.6.0.tar.gz

		einfo "Unpacking ezmlm"
		wget -q http://www.drupal.org/files/projects/ezmlm-4.6.0.tar.gz
		tar xfz ezmlm-4.6.0.tar.gz

		einfo "Unpacking fckeditor"
		wget -q http://www.drupal.org/files/projects/fckeditor-4.6.0.tar.gz
		tar xfz fckeditor-4.6.0.tar.gz

		einfo "Unpacking feedback"
		wget -q http://www.drupal.org/files/projects/feedback-4.6.0.tar.gz
		tar xfz feedback-4.6.0.tar.gz

		einfo "Unpacking filemanager"
		wget -q http://www.drupal.org/files/projects/filemanager-4.6.0.tar.gz
		tar xfz filemanager-4.6.0.tar.gz

		einfo "Unpacking flexinode"
		wget -q http://www.drupal.org/files/projects/flexinode-4.6.0.tar.gz
		tar xfz flexinode-4.6.0.tar.gz

		einfo "Unpacking foaf"
		wget -q http://www.drupal.org/files/projects/foaf-4.6.0.tar.gz
		tar xfz foaf-4.6.0.tar.gz

		einfo "Unpacking folksonomy"
		wget -q http://www.drupal.org/files/projects/folksonomy-4.6.0.tar.gz
		tar xfz folksonomy-4.6.0.tar.gz

		einfo "Unpacking fontsize"
		wget -q http://www.drupal.org/files/projects/fontsize-4.6.0.tar.gz
		tar xfz fontsize-4.6.0.tar.gz

		einfo "Unpacking forms"
		wget -q http://www.drupal.org/files/projects/forms-4.6.0.tar.gz
		tar xfz forms-4.6.0.tar.gz

		einfo "Unpacking form_mail"
		wget -q http://www.drupal.org/files/projects/form_mail-4.6.0.tar.gz
		tar xfz form_mail-4.6.0.tar.gz

		einfo "Unpacking freelinking"
		wget -q http://www.drupal.org/files/projects/freelinking-4.6.0.tar.gz
		tar xfz freelinking-4.6.0.tar.gz

		einfo "Unpacking front"
		wget -q http://www.drupal.org/files/projects/front-4.6.0.tar.gz
		tar xfz front-4.6.0.tar.gz

		einfo "Unpacking gallery"
		wget -q http://www.drupal.org/files/projects/gallery-4.6.0.tar.gz
		tar xfz gallery-4.6.0.tar.gz

		einfo "Unpacking glossary"
		wget -q http://www.drupal.org/files/projects/glossary-4.6.0.tar.gz
		tar xfz glossary-4.6.0.tar.gz

		einfo "Unpacking hof"
		wget -q http://www.drupal.org/files/projects/hof-4.6.0.tar.gz
		tar xfz hof-4.6.0.tar.gz

		einfo "Unpacking helpedit"
		wget -q http://www.drupal.org/files/projects/helpedit-4.6.0.tar.gz
		tar xfz helpedit-4.6.0.tar.gz

		einfo "Unpacking htmlcorrector"
		wget -q http://www.drupal.org/files/projects/htmlcorrector-4.6.0.tar.gz
		tar xfz htmlcorrector-4.6.0.tar.gz

		einfo "Unpacking htmlarea"
		wget -q http://www.drupal.org/files/projects/htmlarea-4.6.0.tar.gz
		tar xfz htmlarea-4.6.0.tar.gz

		einfo "Unpacking image"
		wget -q http://www.drupal.org/files/projects/image-4.6.0.tar.gz
		tar xfz image-4.6.0.tar.gz

		einfo "Unpacking img_assist"
		wget -q http://www.drupal.org/files/projects/img_assist-4.6.0.tar.gz
		tar xfz img_assist-4.6.0.tar.gz

		einfo "Unpacking i18n"
		wget -q http://www.drupal.org/files/projects/i18n-4.6.0.tar.gz
		tar xfz i18n-4.6.0.tar.gz

		einfo "Unpacking interwiki"
		wget -q http://www.drupal.org/files/projects/interwiki-4.6.0.tar.gz
		tar xfz interwiki-4.6.0.tar.gz

		einfo "Unpacking livediscussions"
		wget -q http://www.drupal.org/files/projects/livediscussions-4.6.0.tar.gz
		tar xfz livediscussions-4.6.0.tar.gz

		einfo "Unpacking mailalias"
		wget -q http://www.drupal.org/files/projects/mailalias-4.6.0.tar.gz
		tar xfz mailalias-4.6.0.tar.gz

		einfo "Unpacking mailhandler"
		wget -q http://www.drupal.org/files/projects/mailhandler-4.6.0.tar.gz
		tar xfz mailhandler-4.6.0.tar.gz

		einfo "Unpacking marksmarty"
		wget -q http://www.drupal.org/files/projects/marksmarty-4.6.0.tar.gz
		tar xfz marksmarty-4.6.0.tar.gz

		einfo "Unpacking massmailer"
		wget -q http://www.drupal.org/files/projects/massmailer-4.6.0.tar.gz
		tar xfz massmailer-4.6.0.tar.gz

		einfo "Unpacking members"
		wget -q http://www.drupal.org/files/projects/members-4.6.0.tar.gz
		tar xfz members-4.6.0.tar.gz

		einfo "Unpacking menu_otf"
		wget -q http://www.drupal.org/files/projects/menu_otf-4.6.0.tar.gz
		tar xfz menu_otf-4.6.0.tar.gz

		einfo "Unpacking nodewords"
		wget -q http://www.drupal.org/files/projects/nodewords-4.6.0.tar.gz
		tar xfz nodewords-4.6.0.tar.gz

		einfo "Unpacking nodelist"
		wget -q http://www.drupal.org/files/projects/nodelist-4.6.0.tar.gz
		tar xfz nodelist-4.6.0.tar.gz

		einfo "Unpacking nmoderation"
		wget -q http://www.drupal.org/files/projects/nmoderation-4.6.0.tar.gz
		tar xfz nmoderation-4.6.0.tar.gz

		einfo "Unpacking node_privacy_byrole"
		wget -q http://www.drupal.org/files/projects/node_privacy_byrole-4.6.0.tar.gz
		tar xfz node_privacy_byrole-4.6.0.tar.gz

		einfo "Unpacking node_import"
		wget -q http://www.drupal.org/files/projects/node_import-4.6.0.tar.gz
		tar xfz node_import-4.6.0.tar.gz

		einfo "Unpacking notify"
		wget -q http://www.drupal.org/files/projects/notify-4.6.0.tar.gz
		tar xfz notify-4.6.0.tar.gz

		einfo "Unpacking og"
		wget -q http://www.drupal.org/files/projects/og-4.6.0.tar.gz
		tar xfz og-4.6.0.tar.gz

		einfo "Unpacking pathauto"
		wget -q http://www.drupal.org/files/projects/pathauto-4.6.0.tar.gz
		tar xfz pathauto-4.6.0.tar.gz

		einfo "Unpacking paypal_framework"
		wget -q http://www.drupal.org/files/projects/paypal_framework-4.6.0.tar.gz
		tar xfz paypal_framework-4.6.0.tar.gz

		einfo "Unpacking paypal_subscription"
		wget -q http://www.drupal.org/files/projects/paypal_subscription-4.6.0.tar.gz
		tar xfz paypal_subscription-4.6.0.tar.gz

		einfo "Unpacking poormanscron"
		wget -q http://www.drupal.org/files/projects/poormanscron-4.6.0.tar.gz
		tar xfz poormanscron-4.6.0.tar.gz

		einfo "Unpacking privatemsg"
		wget -q http://www.drupal.org/files/projects/privatemsg-4.6.0.tar.gz
		tar xfz privatemsg-4.6.0.tar.gz

		einfo "Unpacking quote"
		wget -q http://www.drupal.org/files/projects/quote-4.6.0.tar.gz
		tar xfz quote-4.6.0.tar.gz

		einfo "Unpacking quotes"
		wget -q http://www.drupal.org/files/projects/quotes-4.6.0.tar.gz
		tar xfz quotes-4.6.0.tar.gz

		einfo "Unpacking recipe"
		wget -q http://www.drupal.org/files/projects/recipe-4.6.0.tar.gz
		tar xfz recipe-4.6.0.tar.gz

		einfo "Unpacking rsvp"
		wget -q http://www.drupal.org/files/projects/rsvp-4.6.0.tar.gz
		tar xfz rsvp-4.6.0.tar.gz

		einfo "Unpacking scheduler"
		wget -q http://www.drupal.org/files/projects/scheduler-4.6.0.tar.gz
		tar xfz scheduler-4.6.0.tar.gz

		einfo "Unpacking securesite"
		wget -q http://www.drupal.org/files/projects/securesite-4.6.0.tar.gz
		tar xfz securesite-4.6.0.tar.gz

		einfo "Unpacking series"
		wget -q http://www.drupal.org/files/projects/series-4.6.0.tar.gz
		tar xfz series-4.6.0.tar.gz

		einfo "Unpacking sidecontent"
		wget -q http://www.drupal.org/files/projects/sidecontent-4.6.0.tar.gz
		tar xfz sidecontent-4.6.0.tar.gz

		einfo "Unpacking simpletest"
		wget -q http://www.drupal.org/files/projects/simpletest-4.6.0.tar.gz
		tar xfz simpletest-4.6.0.tar.gz

		einfo "Unpacking site_map"
		wget -q http://www.drupal.org/files/projects/site_map-4.6.0.tar.gz
		tar xfz site_map-4.6.0.tar.gz

		einfo "Unpacking sitemenu"
		wget -q http://www.drupal.org/files/projects/sitemenu-4.6.0.tar.gz
		tar xfz sitemenu-4.6.0.tar.gz

		einfo "Unpacking smartypants"
		wget -q http://www.drupal.org/files/projects/smartypants-4.6.0.tar.gz
		tar xfz smartypants-4.6.0.tar.gz

		einfo "Unpacking smileys"
		wget -q http://www.drupal.org/files/projects/smileys-4.6.0.tar.gz
		tar xfz smileys-4.6.0.tar.gz

		einfo "Unpacking spam"
		wget -q http://www.drupal.org/files/projects/spam-4.6.0.tar.gz
		tar xfz spam-4.6.0.tar.gz

		einfo "Unpacking statistics_filter"
		wget -q http://www.drupal.org/files/projects/statistics_filter-4.6.0.tar.gz
		tar xfz statistics_filter-4.6.0.tar.gz

		einfo "Unpacking stock"
		wget -q http://www.drupal.org/files/projects/stock-4.6.0.tar.gz
		tar xfz stock-4.6.0.tar.gz

		einfo "Unpacking subscriptions"
		wget -q http://www.drupal.org/files/projects/subscriptions-4.6.0.tar.gz
		tar xfz subscriptions-4.6.0.tar.gz

		einfo "Unpacking summary"
		wget -q http://www.drupal.org/files/projects/summary-4.6.0.tar.gz
		tar xfz summary-4.6.0.tar.gz

		einfo "Unpacking survey"
		wget -q http://www.drupal.org/files/projects/survey-4.6.0.tar.gz
		tar xfz survey-4.6.0.tar.gz

		einfo "Unpacking sxip"
		wget -q http://www.drupal.org/files/projects/sxip-4.6.0.tar.gz
		tar xfz sxip-4.6.0.tar.gz

		einfo "Unpacking syndication"
		wget -q http://www.drupal.org/files/projects/syndication-4.6.0.tar.gz
		tar xfz syndication-4.6.0.tar.gz

		einfo "Unpacking taxonomy_access"
		wget -q http://www.drupal.org/files/projects/taxonomy_access-4.6.0.tar.gz
		tar xfz taxonomy_access-4.6.0.tar.gz

		einfo "Unpacking taxonomy_block"
		wget -q http://www.drupal.org/files/projects/taxonomy_block-4.6.0.tar.gz
		tar xfz taxonomy_block-4.6.0.tar.gz

		einfo "Unpacking taxonomy_browser"
		wget -q http://www.drupal.org/files/projects/taxonomy_browser-4.6.0.tar.gz
		tar xfz taxonomy_browser-4.6.0.tar.gz

		einfo "Unpacking taxonomy_dhtml"
		wget -q http://www.drupal.org/files/projects/taxonomy_dhtml-4.6.0.tar.gz
		tar xfz taxonomy_dhtml-4.6.0.tar.gz

		einfo "Unpacking taxonomy_xml"
		wget -q http://www.drupal.org/files/projects/taxonomy_xml-4.6.0.tar.gz
		tar xfz taxonomy_xml-4.6.0.tar.gz

		einfo "Unpacking taxonomy_menu"
		wget -q http://www.drupal.org/files/projects/taxonomy_menu-4.6.0.tar.gz
		tar xfz taxonomy_menu-4.6.0.tar.gz

		einfo "Unpacking taxonomy_multi_edit"
		wget -q http://www.drupal.org/files/projects/taxonomy_multi_edit-4.6.0.tar.gz
		tar xfz taxonomy_multi_edit-4.6.0.tar.gz

		einfo "Unpacking textile"
		wget -q http://www.drupal.org/files/projects/textile-4.6.0.tar.gz
		tar xfz textile-4.6.0.tar.gz

		einfo "Unpacking theme_editor"
		wget -q http://www.drupal.org/files/projects/theme_editor-4.6.0.tar.gz
		tar xfz theme_editor-4.6.0.tar.gz

		einfo "Unpacking tinymce"
		wget -q http://www.drupal.org/files/projects/tinymce-4.6.0.tar.gz
		tar xfz tinymce-4.6.0.tar.gz

		einfo "Unpacking urlfilter"
		wget -q http://www.drupal.org/files/projects/urlfilter-4.6.0.tar.gz
		tar xfz urlfilter-4.6.0.tar.gz

		einfo "Unpacking variable"
		wget -q http://www.drupal.org/files/projects/variable-4.6.0.tar.gz
		tar xfz variable-4.6.0.tar.gz

		einfo "Unpacking vimcolor"
		wget -q http://www.drupal.org/files/projects/vimcolor-4.6.0.tar.gz
		tar xfz vimcolor-4.6.0.tar.gz

		einfo "Unpacking webform"
		wget -q http://www.drupal.org/files/projects/webform-4.6.0.tar.gz
		tar xfz webform-4.6.0.tar.gz

		einfo "Unpacking webserver_auth"
		wget -q http://www.drupal.org/files/projects/webserver_auth-4.6.0.tar.gz
		tar xfz webserver_auth-4.6.0.tar.gz

		einfo "Unpacking week"
		wget -q http://www.drupal.org/files/projects/week-4.6.0.tar.gz
		tar xfz week-4.6.0.tar.gz

		cd ${S}/themes
		einfo "Unpacking adc"
		wget -q http://www.drupal.org/files/projects/adc-4.6.0.tar.gz
		tar xfz adc-4.6.0.tar.gz

		einfo "Unpacking blix"
		wget -q http://www.drupal.org/files/projects/blix-4.6.0.tar.gz
		tar xfz blix-4.6.0.tar.gz

		einfo "Unpacking bluemarine"
		wget -q http://www.drupal.org/files/projects/bluemarine-4.6.0.tar.gz
		tar xfz bluemarine-4.6.0.tar.gz

		einfo "Unpacking democratica"
		wget -q http://www.drupal.org/files/projects/democratica-4.6.0.tar.gz
		tar xfz democratica-4.6.0.tar.gz

		einfo "Unpacking friendselectric"
		wget -q http://www.drupal.org/files/projects/friendselectric-4.6.0.tar.gz
		tar xfz friendselectric-4.6.0.tar.gz

		einfo "Unpacking gespaa"
		wget -q http://www.drupal.org/files/projects/gespaa-4.6.0.tar.gz
		tar xfz gespaa-4.6.0.tar.gz

		einfo "Unpacking goofy"
		wget -q http://www.drupal.org/files/projects/goofy-4.6.0.tar.gz
		tar xfz goofy-4.6.0.tar.gz

		einfo "Unpacking greenmarinee"
		wget -q http://www.drupal.org/files/projects/greenmarinee-4.6.0.tar.gz
		tar xfz greenmarinee-4.6.0.tar.gz

		einfo "Unpacking interlaced"
		wget -q http://www.drupal.org/files/projects/interlaced-4.6.0.tar.gz
		tar xfz interlaced-4.6.0.tar.gz

		einfo "Unpacking leaf"
		wget -q http://www.drupal.org/files/projects/leaf-4.6.0.tar.gz
		tar xfz leaf-4.6.0.tar.gz

		einfo "Unpacking lincolns_revenge"
		wget -q http://www.drupal.org/files/projects/lincolns_revenge-4.6.0.tar.gz
		tar xfz lincolns_revenge-4.6.0.tar.gz

		einfo "Unpacking marvinclassic"
		wget -q http://www.drupal.org/files/projects/marvinclassic-4.6.0.tar.gz
		tar xfz marvinclassic-4.6.0.tar.gz

		einfo "Unpacking rdc"
		wget -q http://www.drupal.org/files/projects/rdc-4.6.0.tar.gz
		tar xfz rdc-4.6.0.tar.gz

		einfo "Unpacking slash"
		wget -q http://www.drupal.org/files/projects/slash-4.6.0.tar.gz
		tar xfz slash-4.6.0.tar.gz

		einfo "Unpacking slurpee"
		wget -q http://www.drupal.org/files/projects/slurpee-4.6.0.tar.gz
		tar xfz slurpee-4.6.0.tar.gz

		einfo "Unpacking spreadfirefox"
		wget -q http://www.drupal.org/files/projects/spreadfirefox-4.6.0.tar.gz
		tar xfz spreadfirefox-4.6.0.tar.gz

		einfo "Unpacking sunflower"
		wget -q http://www.drupal.org/files/projects/sunflower-4.6.0.tar.gz
		tar xfz sunflower-4.6.0.tar.gz

		einfo "Unpacking unconed"
		wget -q http://www.drupal.org/files/projects/unconed-4.6.0.tar.gz
		tar xfz unconed-4.6.0.tar.gz

		cd ${S}/includes
		einfo "Unpacking pt-br"
		wget -q http://www.drupal.org/files/projects/pt-br-4.6.0.tar.gz
		tar xfz pt-br-4.6.0.tar.gz

		einfo "Unpacking fr"
		wget -q http://www.drupal.org/files/projects/fr-4.6.0.tar.gz
		tar xfz fr-4.6.0.tar.gz

		einfo "Unpacking hu"
		wget -q http://www.drupal.org/files/projects/hu-4.6.0.tar.gz
		tar xfz hu-4.6.0.tar.gz

		einfo "Unpacking ja"
		wget -q http://www.drupal.org/files/projects/ja-4.6.0.tar.gz
		tar xfz ja-4.6.0.tar.gz

		einfo "Unpacking pl"
		wget -q http://www.drupal.org/files/projects/pl-4.6.0.tar.gz
		tar xfz pl-4.6.0.tar.gz

		einfo "Unpacking pt-pt"
		wget -q http://www.drupal.org/files/projects/pt-pt-4.6.0.tar.gz
		tar xfz pt-pt-4.6.0.tar.gz

		einfo "Unpacking es"
		wget -q http://www.drupal.org/files/projects/es-4.6.0.tar.gz
		tar xfz es-4.6.0.tar.gz

		cd ${S}/themes/engines
		einfo "Unpacking drupal-pot"
		wget -q http://www.drupal.org/files/projects/drupal-pot-4.6.0.tar.gz
		tar xfz drupal-pot-4.6.0.tar.gz

		einfo "Unpacking phptemplate"
		wget -q http://www.drupal.org/files/projects/phptemplate-4.6.0.tar.gz
		tar xfz phptemplate-4.6.0.tar.gz

		find ${S} -name "*.tar.gz" -exec rm -rf {} \;
		find ${S} -type f -exec chmod 644 {} \;
		find ${S} -type d -exec chmod 755 {} \;
	fi
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
