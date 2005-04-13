# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.5.2.ebuild,v 1.4 2005/04/13 14:20:07 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"
MOD_PV="4.5.0"
S="${WORKDIR}/${P}"

SRC_URI="http://drupal.org/files/projects/${P}.tar.gz
	!minimal? (	http://www.drupal.org/files/projects/affiliate-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/album-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/amazon_items-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/amazonsearch-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/api-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/article-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/atom-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/attached_node-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/attachment-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/automember-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/banner-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/bbcode-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/blogroll-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/bookreview-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/bookmarks-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/buddylist-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/captcha-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/challenge_response-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/chatbox-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/codefilter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/collimator-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/commentcloser-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/commentrss-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/contact_dir-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/contextlinks-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/copyright-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/creativecommons-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/csvfilter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/postcount_rank-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/customerror-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/daily-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/dba-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/distantparent-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/donations-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ecommerce-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/editasnew-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/event-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/excerpt-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ezmlm-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/fckeditor-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/feature-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/feedback-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/filebrowser-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/filemanager-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/filestore2-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/flexinode-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/foaf-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/folksonomy-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/fontsize-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/forms-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/form_mail-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/front-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/fscache-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/glossary-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/guestbook-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/helpedit-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/htmlcorrector-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/htmlarea-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/htmltidy-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/image-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/image_filter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/img_assist-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/inline-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/im-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/i18n-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/interwiki-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/jsdomenu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ldap_integration-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/legal-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/listhandler-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/livediscussions-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/livejournal-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/mail-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/mailalias-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/mailhandler-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/marksmarty-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/massmailer-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/members-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/menu_otf-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/mypage-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/news_page-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nicelinks-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nodewords-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nmoderation-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/node_privacy_byrole-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/relativity-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/typecat-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/node_import-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/notify-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/optin-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/og-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/over_text-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pathauto-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/paypal_framework-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/paypal_subscription-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/paypal_tipjar-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pdfview-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/peoplesemailnetwork-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/periodical-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/poormanscron-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/postcard-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/powells-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/print-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/privatemsg-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/project-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pureftp-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/quickpost-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/quicktags-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/quote-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/quotes-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/recipe-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/relatedlinks-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/remindme-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/role_to_file-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/rsvp-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/scheduler-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/series-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sidecontent-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/simpletest-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/site_map-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sitemenu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/smartypants-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/smileys-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/spam-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/statistics_filter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/stock-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/subscriptions-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/summary-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/survey-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/swish-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sxip-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/syndication-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_access-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_assoc-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_block-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_browser-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_context-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_dhtml-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_html-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_image-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_xml-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_menu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/taxonomy_otf-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/term_statistics-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/textile-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/theme_editor-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/themedev-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/title-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/trackback-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/translation-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/trip_search-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/troll-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/urlfilter-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/userposts-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/validation-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/variable-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/volunteer-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/weather-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/webform-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/weblink-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/webserver_auth-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/week-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/wiki-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/workflow-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/workspace-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ystock-${MOD_PV}.tar.gz

			http://www.drupal.org/files/projects/adc-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/box_grey_smarty-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/box_grey-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/democratica-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/friendselectric-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/goofy-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/interlaced-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/kubrick-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/lincolns_revenge-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/manji-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/marvin_2k_phptemplate-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/persian-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pushbutton_phptemplate-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/spreadfirefox-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sunflower-${MOD_PV}.tar.gz

			http://www.drupal.org/files/projects/sq-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ar-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/eu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pt-br-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ca-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/zh-hans-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/cs-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/da-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nl-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/eo-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/fr-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/de-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/hu-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/id-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/it-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ja-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/nno-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pl-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/pt-pt-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ro-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/ru-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/sv-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/drupal-pot-${MOD_PV}.tar.gz

			http://www.drupal.org/files/projects/phptemplate-${MOD_PV}.tar.gz
			http://www.drupal.org/files/projects/smarty-${MOD_PV}.tar.gz
			)"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz

	cd ${S}/modules
	einfo "Unpacking affiliate"
	unpack affiliate-${MOD_PV}.tar.gz
	einfo "Unpacking album"
	unpack album-${MOD_PV}.tar.gz
	einfo "Unpacking amazon_items"
	unpack amazon_items-${MOD_PV}.tar.gz
	einfo "Unpacking amazonsearch"
	unpack amazonsearch-${MOD_PV}.tar.gz
	einfo "Unpacking api"
	unpack api-${MOD_PV}.tar.gz
	einfo "Unpacking article"
	unpack article-${MOD_PV}.tar.gz
	einfo "Unpacking atom"
	unpack atom-${MOD_PV}.tar.gz
	einfo "Unpacking attached_node"
	unpack attached_node-${MOD_PV}.tar.gz
	einfo "Unpacking attachment"
	unpack attachment-${MOD_PV}.tar.gz
	einfo "Unpacking automember"
	unpack automember-${MOD_PV}.tar.gz
	einfo "Unpacking banner"
	unpack banner-${MOD_PV}.tar.gz
	einfo "Unpacking bbcode"
	unpack bbcode-${MOD_PV}.tar.gz
	einfo "Unpacking blogroll"
	unpack blogroll-${MOD_PV}.tar.gz
	einfo "Unpacking bookreview"
	unpack bookreview-${MOD_PV}.tar.gz
	einfo "Unpacking bookmarks"
	unpack bookmarks-${MOD_PV}.tar.gz
	einfo "Unpacking buddylist"
	unpack buddylist-${MOD_PV}.tar.gz
	einfo "Unpacking captcha"
	unpack captcha-${MOD_PV}.tar.gz
	einfo "Unpacking challenge_response"
	unpack challenge_response-${MOD_PV}.tar.gz
	einfo "Unpacking chatbox"
	unpack chatbox-${MOD_PV}.tar.gz
	einfo "Unpacking codefilter"
	unpack codefilter-${MOD_PV}.tar.gz
	einfo "Unpacking collimator"
	unpack collimator-${MOD_PV}.tar.gz
	einfo "Unpacking commentcloser"
	unpack commentcloser-${MOD_PV}.tar.gz
	einfo "Unpacking commentrss"
	unpack commentrss-${MOD_PV}.tar.gz
	einfo "Unpacking contact_dir"
	unpack contact_dir-${MOD_PV}.tar.gz
	einfo "Unpacking contextlinks"
	unpack contextlinks-${MOD_PV}.tar.gz
	einfo "Unpacking copyright"
	unpack copyright-${MOD_PV}.tar.gz
	einfo "Unpacking creativecommons"
	unpack creativecommons-${MOD_PV}.tar.gz
	einfo "Unpacking csvfilter"
	unpack csvfilter-${MOD_PV}.tar.gz
	einfo "Unpacking postcount_rank"
	unpack postcount_rank-${MOD_PV}.tar.gz
	einfo "Unpacking customerror"
	unpack customerror-${MOD_PV}.tar.gz
	einfo "Unpacking daily"
	unpack daily-${MOD_PV}.tar.gz
	einfo "Unpacking dba"
	unpack dba-${MOD_PV}.tar.gz
	einfo "Unpacking distantparent"
	unpack distantparent-${MOD_PV}.tar.gz
	einfo "Unpacking donations"
	unpack donations-${MOD_PV}.tar.gz
	einfo "Unpacking ecommerce"
	unpack ecommerce-${MOD_PV}.tar.gz
	einfo "Unpacking editasnew"
	unpack editasnew-${MOD_PV}.tar.gz
	einfo "Unpacking event"
	unpack event-${MOD_PV}.tar.gz
	einfo "Unpacking excerpt"
	unpack excerpt-${MOD_PV}.tar.gz
	einfo "Unpacking ezmlm"
	unpack ezmlm-${MOD_PV}.tar.gz
	einfo "Unpacking fckeditor"
	unpack fckeditor-${MOD_PV}.tar.gz
	einfo "Unpacking feature"
	unpack feature-${MOD_PV}.tar.gz
	einfo "Unpacking feedback"
	unpack feedback-${MOD_PV}.tar.gz
	einfo "Unpacking filebrowser"
	unpack filebrowser-${MOD_PV}.tar.gz
	einfo "Unpacking filemanager"
	unpack filemanager-${MOD_PV}.tar.gz
	einfo "Unpacking filestore2"
	unpack filestore2-${MOD_PV}.tar.gz
	einfo "Unpacking flexinode"
	unpack flexinode-${MOD_PV}.tar.gz
	einfo "Unpacking foaf"
	unpack foaf-${MOD_PV}.tar.gz
	einfo "Unpacking folksonomy"
	unpack folksonomy-${MOD_PV}.tar.gz
	einfo "Unpacking fontsize"
	unpack fontsize-${MOD_PV}.tar.gz
	einfo "Unpacking forms"
	unpack forms-${MOD_PV}.tar.gz
	einfo "Unpacking form_mail"
	unpack form_mail-${MOD_PV}.tar.gz
	einfo "Unpacking front"
	unpack front-${MOD_PV}.tar.gz
	einfo "Unpacking fscache"
	unpack fscache-${MOD_PV}.tar.gz
	einfo "Unpacking glossary"
	unpack glossary-${MOD_PV}.tar.gz
	einfo "Unpacking guestbook"
	unpack guestbook-${MOD_PV}.tar.gz
	einfo "Unpacking helpedit"
	unpack helpedit-${MOD_PV}.tar.gz
	einfo "Unpacking htmlcorrector"
	unpack htmlcorrector-${MOD_PV}.tar.gz
	einfo "Unpacking htmlarea"
	unpack htmlarea-${MOD_PV}.tar.gz
	einfo "Unpacking htmltidy"
	unpack htmltidy-${MOD_PV}.tar.gz
	einfo "Unpacking image"
	unpack image-${MOD_PV}.tar.gz
	einfo "Unpacking image_filter"
	unpack image_filter-${MOD_PV}.tar.gz
	einfo "Unpacking img_assist"
	unpack img_assist-${MOD_PV}.tar.gz
	einfo "Unpacking inline"
	unpack inline-${MOD_PV}.tar.gz
	einfo "Unpacking im"
	unpack im-${MOD_PV}.tar.gz
	einfo "Unpacking i18n"
	unpack i18n-${MOD_PV}.tar.gz
	einfo "Unpacking interwiki"
	unpack interwiki-${MOD_PV}.tar.gz
	einfo "Unpacking jsdomenu"
	unpack jsdomenu-${MOD_PV}.tar.gz
	einfo "Unpacking ldap_integration"
	unpack ldap_integration-${MOD_PV}.tar.gz
	einfo "Unpacking legal"
	unpack legal-${MOD_PV}.tar.gz
	einfo "Unpacking listhandler"
	unpack listhandler-${MOD_PV}.tar.gz
	einfo "Unpacking livediscussions"
	unpack livediscussions-${MOD_PV}.tar.gz
	einfo "Unpacking livejournal"
	unpack livejournal-${MOD_PV}.tar.gz
	einfo "Unpacking mail"
	unpack mail-${MOD_PV}.tar.gz
	einfo "Unpacking mailalias"
	unpack mailalias-${MOD_PV}.tar.gz
	einfo "Unpacking mailhandler"
	unpack mailhandler-${MOD_PV}.tar.gz
	einfo "Unpacking marksmarty"
	unpack marksmarty-${MOD_PV}.tar.gz
	einfo "Unpacking massmailer"
	unpack massmailer-${MOD_PV}.tar.gz
	einfo "Unpacking members"
	unpack members-${MOD_PV}.tar.gz
	einfo "Unpacking menu_otf"
	unpack menu_otf-${MOD_PV}.tar.gz
	einfo "Unpacking mypage"
	unpack mypage-${MOD_PV}.tar.gz
	einfo "Unpacking news_page"
	unpack news_page-${MOD_PV}.tar.gz
	einfo "Unpacking nicelinks"
	unpack nicelinks-${MOD_PV}.tar.gz
	einfo "Unpacking nodewords"
	unpack nodewords-${MOD_PV}.tar.gz
	einfo "Unpacking nmoderation"
	unpack nmoderation-${MOD_PV}.tar.gz
	einfo "Unpacking node_privacy_byrole"
	unpack node_privacy_byrole-${MOD_PV}.tar.gz
	einfo "Unpacking relativity"
	unpack relativity-${MOD_PV}.tar.gz
	einfo "Unpacking typecat"
	unpack typecat-${MOD_PV}.tar.gz
	einfo "Unpacking node_import"
	unpack node_import-${MOD_PV}.tar.gz
	einfo "Unpacking notify"
	unpack notify-${MOD_PV}.tar.gz
	einfo "Unpacking optin"
	unpack optin-${MOD_PV}.tar.gz
	einfo "Unpacking og"
	unpack og-${MOD_PV}.tar.gz
	einfo "Unpacking over_text"
	unpack over_text-${MOD_PV}.tar.gz
	einfo "Unpacking pathauto"
	unpack pathauto-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_framework"
	unpack paypal_framework-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_subscription"
	unpack paypal_subscription-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_tipjar"
	unpack paypal_tipjar-${MOD_PV}.tar.gz
	einfo "Unpacking pdfview"
	unpack pdfview-${MOD_PV}.tar.gz
	einfo "Unpacking peoplesemailnetwork"
	unpack peoplesemailnetwork-${MOD_PV}.tar.gz
	einfo "Unpacking periodical"
	unpack periodical-${MOD_PV}.tar.gz
	einfo "Unpacking poormanscron"
	unpack poormanscron-${MOD_PV}.tar.gz
	einfo "Unpacking postcard"
	unpack postcard-${MOD_PV}.tar.gz
	einfo "Unpacking powells"
	unpack powells-${MOD_PV}.tar.gz
	einfo "Unpacking print"
	unpack print-${MOD_PV}.tar.gz
	einfo "Unpacking privatemsg"
	unpack privatemsg-${MOD_PV}.tar.gz
	einfo "Unpacking project"
	unpack project-${MOD_PV}.tar.gz
	einfo "Unpacking pureftp"
	unpack pureftp-${MOD_PV}.tar.gz
	einfo "Unpacking quickpost"
	unpack quickpost-${MOD_PV}.tar.gz
	einfo "Unpacking quicktags"
	unpack quicktags-${MOD_PV}.tar.gz
	einfo "Unpacking quote"
	unpack quote-${MOD_PV}.tar.gz
	einfo "Unpacking quotes"
	unpack quotes-${MOD_PV}.tar.gz
	einfo "Unpacking recipe"
	unpack recipe-${MOD_PV}.tar.gz
	einfo "Unpacking relatedlinks"
	unpack relatedlinks-${MOD_PV}.tar.gz
	einfo "Unpacking remindme"
	unpack remindme-${MOD_PV}.tar.gz
	einfo "Unpacking role_to_file"
	unpack role_to_file-${MOD_PV}.tar.gz
	einfo "Unpacking rsvp"
	unpack rsvp-${MOD_PV}.tar.gz
	einfo "Unpacking scheduler"
	unpack scheduler-${MOD_PV}.tar.gz
	einfo "Unpacking series"
	unpack series-${MOD_PV}.tar.gz
	einfo "Unpacking sidecontent"
	unpack sidecontent-${MOD_PV}.tar.gz
	einfo "Unpacking simpletest"
	unpack simpletest-${MOD_PV}.tar.gz
	einfo "Unpacking site_map"
	unpack site_map-${MOD_PV}.tar.gz
	einfo "Unpacking sitemenu"
	unpack sitemenu-${MOD_PV}.tar.gz
	einfo "Unpacking smartypants"
	unpack smartypants-${MOD_PV}.tar.gz
	einfo "Unpacking smileys"
	unpack smileys-${MOD_PV}.tar.gz
	einfo "Unpacking spam"
	unpack spam-${MOD_PV}.tar.gz
	einfo "Unpacking statistics_filter"
	unpack statistics_filter-${MOD_PV}.tar.gz
	einfo "Unpacking stock"
	unpack stock-${MOD_PV}.tar.gz
	einfo "Unpacking subscriptions"
	unpack subscriptions-${MOD_PV}.tar.gz
	einfo "Unpacking summary"
	unpack summary-${MOD_PV}.tar.gz
	einfo "Unpacking survey"
	unpack survey-${MOD_PV}.tar.gz
	einfo "Unpacking swish"
	unpack swish-${MOD_PV}.tar.gz
	einfo "Unpacking sxip"
	unpack sxip-${MOD_PV}.tar.gz
	einfo "Unpacking syndication"
	unpack syndication-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_access"
	unpack taxonomy_access-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_assoc"
	unpack taxonomy_assoc-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_block"
	unpack taxonomy_block-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_browser"
	unpack taxonomy_browser-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_context"
	unpack taxonomy_context-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_dhtml"
	unpack taxonomy_dhtml-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_html"
	unpack taxonomy_html-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_image"
	unpack taxonomy_image-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_xml"
	unpack taxonomy_xml-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_menu"
	unpack taxonomy_menu-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_otf"
	unpack taxonomy_otf-${MOD_PV}.tar.gz
	einfo "Unpacking term_statistics"
	unpack term_statistics-${MOD_PV}.tar.gz
	einfo "Unpacking textile"
	unpack textile-${MOD_PV}.tar.gz
	einfo "Unpacking theme_editor"
	unpack theme_editor-${MOD_PV}.tar.gz
	einfo "Unpacking themedev"
	unpack themedev-${MOD_PV}.tar.gz
	einfo "Unpacking title"
	unpack title-${MOD_PV}.tar.gz
	einfo "Unpacking trackback"
	unpack trackback-${MOD_PV}.tar.gz
	einfo "Unpacking translation"
	unpack translation-${MOD_PV}.tar.gz
	einfo "Unpacking trip_search"
	unpack trip_search-${MOD_PV}.tar.gz
	einfo "Unpacking troll"
	unpack troll-${MOD_PV}.tar.gz
	einfo "Unpacking urlfilter"
	unpack urlfilter-${MOD_PV}.tar.gz
	einfo "Unpacking userposts"
	unpack userposts-${MOD_PV}.tar.gz
	einfo "Unpacking validation"
	unpack validation-${MOD_PV}.tar.gz
	einfo "Unpacking variable"
	unpack variable-${MOD_PV}.tar.gz
	einfo "Unpacking volunteer"
	unpack volunteer-${MOD_PV}.tar.gz
	einfo "Unpacking weather"
	unpack weather-${MOD_PV}.tar.gz
	einfo "Unpacking webform"
	unpack webform-${MOD_PV}.tar.gz
	einfo "Unpacking weblink"
	unpack weblink-${MOD_PV}.tar.gz
	einfo "Unpacking webserver_auth"
	unpack webserver_auth-${MOD_PV}.tar.gz
	einfo "Unpacking week"
	unpack week-${MOD_PV}.tar.gz
	einfo "Unpacking wiki"
	unpack wiki-${MOD_PV}.tar.gz
	einfo "Unpacking workflow"
	unpack workflow-${MOD_PV}.tar.gz
	einfo "Unpacking workspace"
	unpack workspace-${MOD_PV}.tar.gz
	einfo "Unpacking ystock"
	unpack ystock-${MOD_PV}.tar.gz

	cd ${S}/themes
	einfo "Unpacking adc"
	unpack adc-${MOD_PV}.tar.gz
	einfo "Unpacking box_grey_smarty"
	unpack box_grey_smarty-${MOD_PV}.tar.gz
	einfo "Unpacking box_grey"
	unpack box_grey-${MOD_PV}.tar.gz
	einfo "Unpacking democratica"
	unpack democratica-${MOD_PV}.tar.gz
	einfo "Unpacking friendselectric"
	unpack friendselectric-${MOD_PV}.tar.gz
	einfo "Unpacking goofy"
	unpack goofy-${MOD_PV}.tar.gz
	einfo "Unpacking interlaced"
	unpack interlaced-${MOD_PV}.tar.gz
	einfo "Unpacking kubrick"
	unpack kubrick-${MOD_PV}.tar.gz
	einfo "Unpacking lincolns_revenge"
	unpack lincolns_revenge-${MOD_PV}.tar.gz
	einfo "Unpacking manji"
	unpack manji-${MOD_PV}.tar.gz
	einfo "Unpacking marvin_2k_phptemplate"
	unpack marvin_2k_phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking persian"
	unpack persian-${MOD_PV}.tar.gz
	einfo "Unpacking pushbutton_phptemplate"
	unpack pushbutton_phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking spreadfirefox"
	unpack spreadfirefox-${MOD_PV}.tar.gz
	einfo "Unpacking sunflower"
	unpack sunflower-${MOD_PV}.tar.gz

	cd ${S}
	einfo "Unpacking sq"
	unpack sq-${MOD_PV}.tar.gz
	einfo "Unpacking ar"
	unpack ar-${MOD_PV}.tar.gz
	einfo "Unpacking eu"
	unpack eu-${MOD_PV}.tar.gz
	einfo "Unpacking pt-br"
	unpack pt-br-${MOD_PV}.tar.gz
	einfo "Unpacking ca"
	unpack ca-${MOD_PV}.tar.gz
	einfo "Unpacking zh-hans"
	unpack zh-hans-${MOD_PV}.tar.gz
	einfo "Unpacking cs"
	unpack cs-${MOD_PV}.tar.gz
	einfo "Unpacking da"
	unpack da-${MOD_PV}.tar.gz
	einfo "Unpacking nl"
	unpack nl-${MOD_PV}.tar.gz
	einfo "Unpacking eo"
	unpack eo-${MOD_PV}.tar.gz
	einfo "Unpacking fr"
	unpack fr-${MOD_PV}.tar.gz
	einfo "Unpacking de"
	unpack de-${MOD_PV}.tar.gz
	einfo "Unpacking hu"
	unpack hu-${MOD_PV}.tar.gz
	einfo "Unpacking id"
	unpack id-${MOD_PV}.tar.gz
	einfo "Unpacking it"
	unpack it-${MOD_PV}.tar.gz
	einfo "Unpacking ja"
	unpack ja-${MOD_PV}.tar.gz
	einfo "Unpacking nno"
	unpack nno-${MOD_PV}.tar.gz
	einfo "Unpacking pl"
	unpack pl-${MOD_PV}.tar.gz
	einfo "Unpacking pt-pt"
	unpack pt-pt-${MOD_PV}.tar.gz
	einfo "Unpacking ro"
	unpack ro-${MOD_PV}.tar.gz
	einfo "Unpacking ru"
	unpack ru-${MOD_PV}.tar.gz
	einfo "Unpacking sv"
	unpack sv-${MOD_PV}.tar.gz
	einfo "Unpacking drupal-pot"
	unpack drupal-pot-${MOD_PV}.tar.gz

	cd ${S}/themes/engines
	einfo "Unpacking phptemplate"
	unpack phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking smarty"
	unpack smarty-${MOD_PV}.tar.gz
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

