# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.5.2.ebuild,v 1.3 2005/04/13 12:27:37 st_lim Exp $

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
	tar xfz ${DISTDIR}/${P}.tar.gz

	cd ${S}/modules
	einfo "Unpacking affiliate"
	tar xfz ${DISTDIR}/affiliate-${MOD_PV}.tar.gz
	einfo "Unpacking album"
	tar xfz ${DISTDIR}/album-${MOD_PV}.tar.gz
	einfo "Unpacking amazon_items"
	tar xfz ${DISTDIR}/amazon_items-${MOD_PV}.tar.gz
	einfo "Unpacking amazonsearch"
	tar xfz ${DISTDIR}/amazonsearch-${MOD_PV}.tar.gz
	einfo "Unpacking api"
	tar xfz ${DISTDIR}/api-${MOD_PV}.tar.gz
	einfo "Unpacking article"
	tar xfz ${DISTDIR}/article-${MOD_PV}.tar.gz
	einfo "Unpacking atom"
	tar xfz ${DISTDIR}/atom-${MOD_PV}.tar.gz
	einfo "Unpacking attached_node"
	tar xfz ${DISTDIR}/attached_node-${MOD_PV}.tar.gz
	einfo "Unpacking attachment"
	tar xfz ${DISTDIR}/attachment-${MOD_PV}.tar.gz
	einfo "Unpacking automember"
	tar xfz ${DISTDIR}/automember-${MOD_PV}.tar.gz
	einfo "Unpacking banner"
	tar xfz ${DISTDIR}/banner-${MOD_PV}.tar.gz
	einfo "Unpacking bbcode"
	tar xfz ${DISTDIR}/bbcode-${MOD_PV}.tar.gz
	einfo "Unpacking blogroll"
	tar xfz ${DISTDIR}/blogroll-${MOD_PV}.tar.gz
	einfo "Unpacking bookreview"
	tar xfz ${DISTDIR}/bookreview-${MOD_PV}.tar.gz
	einfo "Unpacking bookmarks"
	tar xfz ${DISTDIR}/bookmarks-${MOD_PV}.tar.gz
	einfo "Unpacking buddylist"
	tar xfz ${DISTDIR}/buddylist-${MOD_PV}.tar.gz
	einfo "Unpacking captcha"
	tar xfz ${DISTDIR}/captcha-${MOD_PV}.tar.gz
	einfo "Unpacking challenge_response"
	tar xfz ${DISTDIR}/challenge_response-${MOD_PV}.tar.gz
	einfo "Unpacking chatbox"
	tar xfz ${DISTDIR}/chatbox-${MOD_PV}.tar.gz
	einfo "Unpacking codefilter"
	tar xfz ${DISTDIR}/codefilter-${MOD_PV}.tar.gz
	einfo "Unpacking collimator"
	tar xfz ${DISTDIR}/collimator-${MOD_PV}.tar.gz
	einfo "Unpacking commentcloser"
	tar xfz ${DISTDIR}/commentcloser-${MOD_PV}.tar.gz
	einfo "Unpacking commentrss"
	tar xfz ${DISTDIR}/commentrss-${MOD_PV}.tar.gz
	einfo "Unpacking contact_dir"
	tar xfz ${DISTDIR}/contact_dir-${MOD_PV}.tar.gz
	einfo "Unpacking contextlinks"
	tar xfz ${DISTDIR}/contextlinks-${MOD_PV}.tar.gz
	einfo "Unpacking copyright"
	tar xfz ${DISTDIR}/copyright-${MOD_PV}.tar.gz
	einfo "Unpacking creativecommons"
	tar xfz ${DISTDIR}/creativecommons-${MOD_PV}.tar.gz
	einfo "Unpacking csvfilter"
	tar xfz ${DISTDIR}/csvfilter-${MOD_PV}.tar.gz
	einfo "Unpacking postcount_rank"
	tar xfz ${DISTDIR}/postcount_rank-${MOD_PV}.tar.gz
	einfo "Unpacking customerror"
	tar xfz ${DISTDIR}/customerror-${MOD_PV}.tar.gz
	einfo "Unpacking daily"
	tar xfz ${DISTDIR}/daily-${MOD_PV}.tar.gz
	einfo "Unpacking dba"
	tar xfz ${DISTDIR}/dba-${MOD_PV}.tar.gz
	einfo "Unpacking distantparent"
	tar xfz ${DISTDIR}/distantparent-${MOD_PV}.tar.gz
	einfo "Unpacking donations"
	tar xfz ${DISTDIR}/donations-${MOD_PV}.tar.gz
	einfo "Unpacking ecommerce"
	tar xfz ${DISTDIR}/ecommerce-${MOD_PV}.tar.gz
	einfo "Unpacking editasnew"
	tar xfz ${DISTDIR}/editasnew-${MOD_PV}.tar.gz
	einfo "Unpacking event"
	tar xfz ${DISTDIR}/event-${MOD_PV}.tar.gz
	einfo "Unpacking excerpt"
	tar xfz ${DISTDIR}/excerpt-${MOD_PV}.tar.gz
	einfo "Unpacking ezmlm"
	tar xfz ${DISTDIR}/ezmlm-${MOD_PV}.tar.gz
	einfo "Unpacking fckeditor"
	tar xfz ${DISTDIR}/fckeditor-${MOD_PV}.tar.gz
	einfo "Unpacking feature"
	tar xfz ${DISTDIR}/feature-${MOD_PV}.tar.gz
	einfo "Unpacking feedback"
	tar xfz ${DISTDIR}/feedback-${MOD_PV}.tar.gz
	einfo "Unpacking filebrowser"
	tar xfz ${DISTDIR}/filebrowser-${MOD_PV}.tar.gz
	einfo "Unpacking filemanager"
	tar xfz ${DISTDIR}/filemanager-${MOD_PV}.tar.gz
	einfo "Unpacking filestore2"
	tar xfz ${DISTDIR}/filestore2-${MOD_PV}.tar.gz
	einfo "Unpacking flexinode"
	tar xfz ${DISTDIR}/flexinode-${MOD_PV}.tar.gz
	einfo "Unpacking foaf"
	tar xfz ${DISTDIR}/foaf-${MOD_PV}.tar.gz
	einfo "Unpacking folksonomy"
	tar xfz ${DISTDIR}/folksonomy-${MOD_PV}.tar.gz
	einfo "Unpacking fontsize"
	tar xfz ${DISTDIR}/fontsize-${MOD_PV}.tar.gz
	einfo "Unpacking forms"
	tar xfz ${DISTDIR}/forms-${MOD_PV}.tar.gz
	einfo "Unpacking form_mail"
	tar xfz ${DISTDIR}/form_mail-${MOD_PV}.tar.gz
	einfo "Unpacking front"
	tar xfz ${DISTDIR}/front-${MOD_PV}.tar.gz
	einfo "Unpacking fscache"
	tar xfz ${DISTDIR}/fscache-${MOD_PV}.tar.gz
	einfo "Unpacking glossary"
	tar xfz ${DISTDIR}/glossary-${MOD_PV}.tar.gz
	einfo "Unpacking guestbook"
	tar xfz ${DISTDIR}/guestbook-${MOD_PV}.tar.gz
	einfo "Unpacking helpedit"
	tar xfz ${DISTDIR}/helpedit-${MOD_PV}.tar.gz
	einfo "Unpacking htmlcorrector"
	tar xfz ${DISTDIR}/htmlcorrector-${MOD_PV}.tar.gz
	einfo "Unpacking htmlarea"
	tar xfz ${DISTDIR}/htmlarea-${MOD_PV}.tar.gz
	einfo "Unpacking htmltidy"
	tar xfz ${DISTDIR}/htmltidy-${MOD_PV}.tar.gz
	einfo "Unpacking image"
	tar xfz ${DISTDIR}/image-${MOD_PV}.tar.gz
	einfo "Unpacking image_filter"
	tar xfz ${DISTDIR}/image_filter-${MOD_PV}.tar.gz
	einfo "Unpacking img_assist"
	tar xfz ${DISTDIR}/img_assist-${MOD_PV}.tar.gz
	einfo "Unpacking inline"
	tar xfz ${DISTDIR}/inline-${MOD_PV}.tar.gz
	einfo "Unpacking im"
	tar xfz ${DISTDIR}/im-${MOD_PV}.tar.gz
	einfo "Unpacking i18n"
	tar xfz ${DISTDIR}/i18n-${MOD_PV}.tar.gz
	einfo "Unpacking interwiki"
	tar xfz ${DISTDIR}/interwiki-${MOD_PV}.tar.gz
	einfo "Unpacking jsdomenu"
	tar xfz ${DISTDIR}/jsdomenu-${MOD_PV}.tar.gz
	einfo "Unpacking ldap_integration"
	tar xfz ${DISTDIR}/ldap_integration-${MOD_PV}.tar.gz
	einfo "Unpacking legal"
	tar xfz ${DISTDIR}/legal-${MOD_PV}.tar.gz
	einfo "Unpacking listhandler"
	tar xfz ${DISTDIR}/listhandler-${MOD_PV}.tar.gz
	einfo "Unpacking livediscussions"
	tar xfz ${DISTDIR}/livediscussions-${MOD_PV}.tar.gz
	einfo "Unpacking livejournal"
	tar xfz ${DISTDIR}/livejournal-${MOD_PV}.tar.gz
	einfo "Unpacking mail"
	tar xfz ${DISTDIR}/mail-${MOD_PV}.tar.gz
	einfo "Unpacking mailalias"
	tar xfz ${DISTDIR}/mailalias-${MOD_PV}.tar.gz
	einfo "Unpacking mailhandler"
	tar xfz ${DISTDIR}/mailhandler-${MOD_PV}.tar.gz
	einfo "Unpacking marksmarty"
	tar xfz ${DISTDIR}/marksmarty-${MOD_PV}.tar.gz
	einfo "Unpacking massmailer"
	tar xfz ${DISTDIR}/massmailer-${MOD_PV}.tar.gz
	einfo "Unpacking members"
	tar xfz ${DISTDIR}/members-${MOD_PV}.tar.gz
	einfo "Unpacking menu_otf"
	tar xfz ${DISTDIR}/menu_otf-${MOD_PV}.tar.gz
	einfo "Unpacking mypage"
	tar xfz ${DISTDIR}/mypage-${MOD_PV}.tar.gz
	einfo "Unpacking news_page"
	tar xfz ${DISTDIR}/news_page-${MOD_PV}.tar.gz
	einfo "Unpacking nicelinks"
	tar xfz ${DISTDIR}/nicelinks-${MOD_PV}.tar.gz
	einfo "Unpacking nodewords"
	tar xfz ${DISTDIR}/nodewords-${MOD_PV}.tar.gz
	einfo "Unpacking nmoderation"
	tar xfz ${DISTDIR}/nmoderation-${MOD_PV}.tar.gz
	einfo "Unpacking node_privacy_byrole"
	tar xfz ${DISTDIR}/node_privacy_byrole-${MOD_PV}.tar.gz
	einfo "Unpacking relativity"
	tar xfz ${DISTDIR}/relativity-${MOD_PV}.tar.gz
	einfo "Unpacking typecat"
	tar xfz ${DISTDIR}/typecat-${MOD_PV}.tar.gz
	einfo "Unpacking node_import"
	tar xfz ${DISTDIR}/node_import-${MOD_PV}.tar.gz
	einfo "Unpacking notify"
	tar xfz ${DISTDIR}/notify-${MOD_PV}.tar.gz
	einfo "Unpacking optin"
	tar xfz ${DISTDIR}/optin-${MOD_PV}.tar.gz
	einfo "Unpacking og"
	tar xfz ${DISTDIR}/og-${MOD_PV}.tar.gz
	einfo "Unpacking over_text"
	tar xfz ${DISTDIR}/over_text-${MOD_PV}.tar.gz
	einfo "Unpacking pathauto"
	tar xfz ${DISTDIR}/pathauto-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_framework"
	tar xfz ${DISTDIR}/paypal_framework-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_subscription"
	tar xfz ${DISTDIR}/paypal_subscription-${MOD_PV}.tar.gz
	einfo "Unpacking paypal_tipjar"
	tar xfz ${DISTDIR}/paypal_tipjar-${MOD_PV}.tar.gz
	einfo "Unpacking pdfview"
	tar xfz ${DISTDIR}/pdfview-${MOD_PV}.tar.gz
	einfo "Unpacking peoplesemailnetwork"
	tar xfz ${DISTDIR}/peoplesemailnetwork-${MOD_PV}.tar.gz
	einfo "Unpacking periodical"
	tar xfz ${DISTDIR}/periodical-${MOD_PV}.tar.gz
	einfo "Unpacking poormanscron"
	tar xfz ${DISTDIR}/poormanscron-${MOD_PV}.tar.gz
	einfo "Unpacking postcard"
	tar xfz ${DISTDIR}/postcard-${MOD_PV}.tar.gz
	einfo "Unpacking powells"
	tar xfz ${DISTDIR}/powells-${MOD_PV}.tar.gz
	einfo "Unpacking print"
	tar xfz ${DISTDIR}/print-${MOD_PV}.tar.gz
	einfo "Unpacking privatemsg"
	tar xfz ${DISTDIR}/privatemsg-${MOD_PV}.tar.gz
	einfo "Unpacking project"
	tar xfz ${DISTDIR}/project-${MOD_PV}.tar.gz
	einfo "Unpacking pureftp"
	tar xfz ${DISTDIR}/pureftp-${MOD_PV}.tar.gz
	einfo "Unpacking quickpost"
	tar xfz ${DISTDIR}/quickpost-${MOD_PV}.tar.gz
	einfo "Unpacking quicktags"
	tar xfz ${DISTDIR}/quicktags-${MOD_PV}.tar.gz
	einfo "Unpacking quote"
	tar xfz ${DISTDIR}/quote-${MOD_PV}.tar.gz
	einfo "Unpacking quotes"
	tar xfz ${DISTDIR}/quotes-${MOD_PV}.tar.gz
	einfo "Unpacking recipe"
	tar xfz ${DISTDIR}/recipe-${MOD_PV}.tar.gz
	einfo "Unpacking relatedlinks"
	tar xfz ${DISTDIR}/relatedlinks-${MOD_PV}.tar.gz
	einfo "Unpacking remindme"
	tar xfz ${DISTDIR}/remindme-${MOD_PV}.tar.gz
	einfo "Unpacking role_to_file"
	tar xfz ${DISTDIR}/role_to_file-${MOD_PV}.tar.gz
	einfo "Unpacking rsvp"
	tar xfz ${DISTDIR}/rsvp-${MOD_PV}.tar.gz
	einfo "Unpacking scheduler"
	tar xfz ${DISTDIR}/scheduler-${MOD_PV}.tar.gz
	einfo "Unpacking series"
	tar xfz ${DISTDIR}/series-${MOD_PV}.tar.gz
	einfo "Unpacking sidecontent"
	tar xfz ${DISTDIR}/sidecontent-${MOD_PV}.tar.gz
	einfo "Unpacking simpletest"
	tar xfz ${DISTDIR}/simpletest-${MOD_PV}.tar.gz
	einfo "Unpacking site_map"
	tar xfz ${DISTDIR}/site_map-${MOD_PV}.tar.gz
	einfo "Unpacking sitemenu"
	tar xfz ${DISTDIR}/sitemenu-${MOD_PV}.tar.gz
	einfo "Unpacking smartypants"
	tar xfz ${DISTDIR}/smartypants-${MOD_PV}.tar.gz
	einfo "Unpacking smileys"
	tar xfz ${DISTDIR}/smileys-${MOD_PV}.tar.gz
	einfo "Unpacking spam"
	tar xfz ${DISTDIR}/spam-${MOD_PV}.tar.gz
	einfo "Unpacking statistics_filter"
	tar xfz ${DISTDIR}/statistics_filter-${MOD_PV}.tar.gz
	einfo "Unpacking stock"
	tar xfz ${DISTDIR}/stock-${MOD_PV}.tar.gz
	einfo "Unpacking subscriptions"
	tar xfz ${DISTDIR}/subscriptions-${MOD_PV}.tar.gz
	einfo "Unpacking summary"
	tar xfz ${DISTDIR}/summary-${MOD_PV}.tar.gz
	einfo "Unpacking survey"
	tar xfz ${DISTDIR}/survey-${MOD_PV}.tar.gz
	einfo "Unpacking swish"
	tar xfz ${DISTDIR}/swish-${MOD_PV}.tar.gz
	einfo "Unpacking sxip"
	tar xfz ${DISTDIR}/sxip-${MOD_PV}.tar.gz
	einfo "Unpacking syndication"
	tar xfz ${DISTDIR}/syndication-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_access"
	tar xfz ${DISTDIR}/taxonomy_access-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_assoc"
	tar xfz ${DISTDIR}/taxonomy_assoc-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_block"
	tar xfz ${DISTDIR}/taxonomy_block-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_browser"
	tar xfz ${DISTDIR}/taxonomy_browser-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_context"
	tar xfz ${DISTDIR}/taxonomy_context-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_dhtml"
	tar xfz ${DISTDIR}/taxonomy_dhtml-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_html"
	tar xfz ${DISTDIR}/taxonomy_html-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_image"
	tar xfz ${DISTDIR}/taxonomy_image-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_xml"
	tar xfz ${DISTDIR}/taxonomy_xml-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_menu"
	tar xfz ${DISTDIR}/taxonomy_menu-${MOD_PV}.tar.gz
	einfo "Unpacking taxonomy_otf"
	tar xfz ${DISTDIR}/taxonomy_otf-${MOD_PV}.tar.gz
	einfo "Unpacking term_statistics"
	tar xfz ${DISTDIR}/term_statistics-${MOD_PV}.tar.gz
	einfo "Unpacking textile"
	tar xfz ${DISTDIR}/textile-${MOD_PV}.tar.gz
	einfo "Unpacking theme_editor"
	tar xfz ${DISTDIR}/theme_editor-${MOD_PV}.tar.gz
	einfo "Unpacking themedev"
	tar xfz ${DISTDIR}/themedev-${MOD_PV}.tar.gz
	einfo "Unpacking title"
	tar xfz ${DISTDIR}/title-${MOD_PV}.tar.gz
	einfo "Unpacking trackback"
	tar xfz ${DISTDIR}/trackback-${MOD_PV}.tar.gz
	einfo "Unpacking translation"
	tar xfz ${DISTDIR}/translation-${MOD_PV}.tar.gz
	einfo "Unpacking trip_search"
	tar xfz ${DISTDIR}/trip_search-${MOD_PV}.tar.gz
	einfo "Unpacking troll"
	tar xfz ${DISTDIR}/troll-${MOD_PV}.tar.gz
	einfo "Unpacking urlfilter"
	tar xfz ${DISTDIR}/urlfilter-${MOD_PV}.tar.gz
	einfo "Unpacking userposts"
	tar xfz ${DISTDIR}/userposts-${MOD_PV}.tar.gz
	einfo "Unpacking validation"
	tar xfz ${DISTDIR}/validation-${MOD_PV}.tar.gz
	einfo "Unpacking variable"
	tar xfz ${DISTDIR}/variable-${MOD_PV}.tar.gz
	einfo "Unpacking volunteer"
	tar xfz ${DISTDIR}/volunteer-${MOD_PV}.tar.gz
	einfo "Unpacking weather"
	tar xfz ${DISTDIR}/weather-${MOD_PV}.tar.gz
	einfo "Unpacking webform"
	tar xfz ${DISTDIR}/webform-${MOD_PV}.tar.gz
	einfo "Unpacking weblink"
	tar xfz ${DISTDIR}/weblink-${MOD_PV}.tar.gz
	einfo "Unpacking webserver_auth"
	tar xfz ${DISTDIR}/webserver_auth-${MOD_PV}.tar.gz
	einfo "Unpacking week"
	tar xfz ${DISTDIR}/week-${MOD_PV}.tar.gz
	einfo "Unpacking wiki"
	tar xfz ${DISTDIR}/wiki-${MOD_PV}.tar.gz
	einfo "Unpacking workflow"
	tar xfz ${DISTDIR}/workflow-${MOD_PV}.tar.gz
	einfo "Unpacking workspace"
	tar xfz ${DISTDIR}/workspace-${MOD_PV}.tar.gz
	einfo "Unpacking ystock"
	tar xfz ${DISTDIR}/ystock-${MOD_PV}.tar.gz

	cd ${S}/themes
	einfo "Unpacking adc"
	tar xfz ${DISTDIR}/adc-${MOD_PV}.tar.gz
	einfo "Unpacking box_grey_smarty"
	tar xfz ${DISTDIR}/box_grey_smarty-${MOD_PV}.tar.gz
	einfo "Unpacking box_grey"
	tar xfz ${DISTDIR}/box_grey-${MOD_PV}.tar.gz
	einfo "Unpacking democratica"
	tar xfz ${DISTDIR}/democratica-${MOD_PV}.tar.gz
	einfo "Unpacking friendselectric"
	tar xfz ${DISTDIR}/friendselectric-${MOD_PV}.tar.gz
	einfo "Unpacking goofy"
	tar xfz ${DISTDIR}/goofy-${MOD_PV}.tar.gz
	einfo "Unpacking interlaced"
	tar xfz ${DISTDIR}/interlaced-${MOD_PV}.tar.gz
	einfo "Unpacking kubrick"
	tar xfz ${DISTDIR}/kubrick-${MOD_PV}.tar.gz
	einfo "Unpacking lincolns_revenge"
	tar xfz ${DISTDIR}/lincolns_revenge-${MOD_PV}.tar.gz
	einfo "Unpacking manji"
	tar xfz ${DISTDIR}/manji-${MOD_PV}.tar.gz
	einfo "Unpacking marvin_2k_phptemplate"
	tar xfz ${DISTDIR}/marvin_2k_phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking persian"
	tar xfz ${DISTDIR}/persian-${MOD_PV}.tar.gz
	einfo "Unpacking pushbutton_phptemplate"
	tar xfz ${DISTDIR}/pushbutton_phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking spreadfirefox"
	tar xfz ${DISTDIR}/spreadfirefox-${MOD_PV}.tar.gz
	einfo "Unpacking sunflower"
	tar xfz ${DISTDIR}/sunflower-${MOD_PV}.tar.gz

	cd ${S}
	einfo "Unpacking sq"
	tar xfz ${DISTDIR}/sq-${MOD_PV}.tar.gz
	einfo "Unpacking ar"
	tar xfz ${DISTDIR}/ar-${MOD_PV}.tar.gz
	einfo "Unpacking eu"
	tar xfz ${DISTDIR}/eu-${MOD_PV}.tar.gz
	einfo "Unpacking pt-br"
	tar xfz ${DISTDIR}/pt-br-${MOD_PV}.tar.gz
	einfo "Unpacking ca"
	tar xfz ${DISTDIR}/ca-${MOD_PV}.tar.gz
	einfo "Unpacking zh-hans"
	tar xfz ${DISTDIR}/zh-hans-${MOD_PV}.tar.gz
	einfo "Unpacking cs"
	tar xfz ${DISTDIR}/cs-${MOD_PV}.tar.gz
	einfo "Unpacking da"
	tar xfz ${DISTDIR}/da-${MOD_PV}.tar.gz
	einfo "Unpacking nl"
	tar xfz ${DISTDIR}/nl-${MOD_PV}.tar.gz
	einfo "Unpacking eo"
	tar xfz ${DISTDIR}/eo-${MOD_PV}.tar.gz
	einfo "Unpacking fr"
	tar xfz ${DISTDIR}/fr-${MOD_PV}.tar.gz
	einfo "Unpacking de"
	tar xfz ${DISTDIR}/de-${MOD_PV}.tar.gz
	einfo "Unpacking hu"
	tar xfz ${DISTDIR}/hu-${MOD_PV}.tar.gz
	einfo "Unpacking id"
	tar xfz ${DISTDIR}/id-${MOD_PV}.tar.gz
	einfo "Unpacking it"
	tar xfz ${DISTDIR}/it-${MOD_PV}.tar.gz
	einfo "Unpacking ja"
	tar xfz ${DISTDIR}/ja-${MOD_PV}.tar.gz
	einfo "Unpacking nno"
	tar xfz ${DISTDIR}/nno-${MOD_PV}.tar.gz
	einfo "Unpacking pl"
	tar xfz ${DISTDIR}/pl-${MOD_PV}.tar.gz
	einfo "Unpacking pt-pt"
	tar xfz ${DISTDIR}/pt-pt-${MOD_PV}.tar.gz
	einfo "Unpacking ro"
	tar xfz ${DISTDIR}/ro-${MOD_PV}.tar.gz
	einfo "Unpacking ru"
	tar xfz ${DISTDIR}/ru-${MOD_PV}.tar.gz
	einfo "Unpacking sv"
	tar xfz ${DISTDIR}/sv-${MOD_PV}.tar.gz
	einfo "Unpacking drupal-pot"
	tar xfz ${DISTDIR}/drupal-pot-${MOD_PV}.tar.gz

	cd ${S}/themes/engines
	einfo "Unpacking phptemplate"
	tar xfz ${DISTDIR}/phptemplate-${MOD_PV}.tar.gz
	einfo "Unpacking smarty"
	tar xfz ${DISTDIR}/smarty-${MOD_PV}.tar.gz
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

