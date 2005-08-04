# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.5.2.ebuild,v 1.9 2005/08/04 09:08:24 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="minimal"
MOD_PV="4.5.0"

SRC_URI="http://drupal.org/files/projects/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~amd64"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz

	if ! use minimal ; then
		cd ${S}/modules
		einfo "Unpacking affiliate"
		wget http://www.drupal.org/files/projects/affiliate-${MOD_PV}.tar.gz
		tar xfz affiliate-${MOD_PV}.tar.gz
		einfo "Unpacking album"
		wget http://www.drupal.org/files/projects/album-${MOD_PV}.tar.gz
		tar xfz album-${MOD_PV}.tar.gz
		einfo "Unpacking amazon_items"
		wget http://www.drupal.org/files/projects/amazon_items-${MOD_PV}.tar.gz
		tar xfz amazon_items-${MOD_PV}.tar.gz
		einfo "Unpacking amazonsearch"
		wget http://www.drupal.org/files/projects/amazonsearch-${MOD_PV}.tar.gz
		tar xfz amazonsearch-${MOD_PV}.tar.gz
		einfo "Unpacking api"
		wget http://www.drupal.org/files/projects/api-${MOD_PV}.tar.gz
		tar xfz api-${MOD_PV}.tar.gz
		einfo "Unpacking article"
		wget http://www.drupal.org/files/projects/article-${MOD_PV}.tar.gz
		tar xfz article-${MOD_PV}.tar.gz
		einfo "Unpacking atom"
		wget http://www.drupal.org/files/projects/atom-${MOD_PV}.tar.gz
		tar xfz atom-${MOD_PV}.tar.gz
		einfo "Unpacking attached_node"
		wget http://www.drupal.org/files/projects/attached_node-${MOD_PV}.tar.gz
		tar xfz attached_node-${MOD_PV}.tar.gz
		einfo "Unpacking attachment"
		wget http://www.drupal.org/files/projects/attachment-${MOD_PV}.tar.gz
		tar xfz attachment-${MOD_PV}.tar.gz
		einfo "Unpacking automember"
		wget http://www.drupal.org/files/projects/automember-${MOD_PV}.tar.gz
		tar xfz automember-${MOD_PV}.tar.gz
		einfo "Unpacking banner"
		wget http://www.drupal.org/files/projects/banner-${MOD_PV}.tar.gz
		tar xfz banner-${MOD_PV}.tar.gz
		einfo "Unpacking bbcode"
		wget http://www.drupal.org/files/projects/bbcode-${MOD_PV}.tar.gz
		tar xfz bbcode-${MOD_PV}.tar.gz
		einfo "Unpacking blogroll"
		wget http://www.drupal.org/files/projects/blogroll-${MOD_PV}.tar.gz
		tar xfz blogroll-${MOD_PV}.tar.gz
		einfo "Unpacking bookreview"
		wget http://www.drupal.org/files/projects/bookreview-${MOD_PV}.tar.gz
		tar xfz bookreview-${MOD_PV}.tar.gz
		einfo "Unpacking bookmarks"
		wget http://www.drupal.org/files/projects/bookmarks-${MOD_PV}.tar.gz
		tar xfz bookmarks-${MOD_PV}.tar.gz
		einfo "Unpacking buddylist"
		wget http://www.drupal.org/files/projects/buddylist-${MOD_PV}.tar.gz
		tar xfz buddylist-${MOD_PV}.tar.gz
		einfo "Unpacking captcha"
		wget http://www.drupal.org/files/projects/captcha-${MOD_PV}.tar.gz
		tar xfz captcha-${MOD_PV}.tar.gz
		einfo "Unpacking challenge_response"
		wget http://www.drupal.org/files/projects/challenge_response-${MOD_PV}.tar.gz
		tar xfz challenge_response-${MOD_PV}.tar.gz
		einfo "Unpacking chatbox"
		wget http://www.drupal.org/files/projects/chatbox-${MOD_PV}.tar.gz
		tar xfz chatbox-${MOD_PV}.tar.gz
		einfo "Unpacking codefilter"
		wget http://www.drupal.org/files/projects/codefilter-${MOD_PV}.tar.gz
		tar xfz codefilter-${MOD_PV}.tar.gz
		einfo "Unpacking collimator"
		wget http://www.drupal.org/files/projects/collimator-${MOD_PV}.tar.gz
		tar xfz collimator-${MOD_PV}.tar.gz
		einfo "Unpacking commentcloser"
		wget http://www.drupal.org/files/projects/commentcloser-${MOD_PV}.tar.gz
		tar xfz commentcloser-${MOD_PV}.tar.gz
		einfo "Unpacking commentrss"
		wget http://www.drupal.org/files/projects/commentrss-${MOD_PV}.tar.gz
		tar xfz commentrss-${MOD_PV}.tar.gz
		einfo "Unpacking contact_dir"
		wget http://www.drupal.org/files/projects/contact_dir-${MOD_PV}.tar.gz
		tar xfz contact_dir-${MOD_PV}.tar.gz
		einfo "Unpacking contextlinks"
		wget http://www.drupal.org/files/projects/contextlinks-${MOD_PV}.tar.gz
		tar xfz contextlinks-${MOD_PV}.tar.gz
		einfo "Unpacking copyright"
		wget http://www.drupal.org/files/projects/copyright-${MOD_PV}.tar.gz
		tar xfz copyright-${MOD_PV}.tar.gz
		einfo "Unpacking creativecommons"
		wget http://www.drupal.org/files/projects/creativecommons-${MOD_PV}.tar.gz
		tar xfz creativecommons-${MOD_PV}.tar.gz
		einfo "Unpacking csvfilter"
		wget http://www.drupal.org/files/projects/csvfilter-${MOD_PV}.tar.gz
		tar xfz csvfilter-${MOD_PV}.tar.gz
		einfo "Unpacking postcount_rank"
		wget http://www.drupal.org/files/projects/postcount_rank-${MOD_PV}.tar.gz
		tar xfz postcount_rank-${MOD_PV}.tar.gz
		einfo "Unpacking customerror"
		wget http://www.drupal.org/files/projects/customerror-${MOD_PV}.tar.gz
		tar xfz customerror-${MOD_PV}.tar.gz
		einfo "Unpacking daily"
		wget http://www.drupal.org/files/projects/daily-${MOD_PV}.tar.gz
		tar xfz daily-${MOD_PV}.tar.gz
		einfo "Unpacking dba"
		wget http://www.drupal.org/files/projects/dba-${MOD_PV}.tar.gz
		tar xfz dba-${MOD_PV}.tar.gz
		einfo "Unpacking distantparent"
		wget http://www.drupal.org/files/projects/distantparent-${MOD_PV}.tar.gz
		tar xfz distantparent-${MOD_PV}.tar.gz
		einfo "Unpacking donations"
		wget http://www.drupal.org/files/projects/donations-${MOD_PV}.tar.gz
		tar xfz donations-${MOD_PV}.tar.gz
		einfo "Unpacking ecommerce"
		wget http://www.drupal.org/files/projects/ecommerce-${MOD_PV}.tar.gz
		tar xfz ecommerce-${MOD_PV}.tar.gz
		einfo "Unpacking editasnew"
		wget http://www.drupal.org/files/projects/editasnew-${MOD_PV}.tar.gz
		tar xfz editasnew-${MOD_PV}.tar.gz
		einfo "Unpacking event"
		wget http://www.drupal.org/files/projects/event-${MOD_PV}.tar.gz
		tar xfz event-${MOD_PV}.tar.gz
		einfo "Unpacking excerpt"
		wget http://www.drupal.org/files/projects/excerpt-${MOD_PV}.tar.gz
		tar xfz excerpt-${MOD_PV}.tar.gz
		einfo "Unpacking ezmlm"
		wget http://www.drupal.org/files/projects/ezmlm-${MOD_PV}.tar.gz
		tar xfz ezmlm-${MOD_PV}.tar.gz
		einfo "Unpacking fckeditor"
		wget http://www.drupal.org/files/projects/fckeditor-${MOD_PV}.tar.gz
		tar xfz fckeditor-${MOD_PV}.tar.gz
		einfo "Unpacking feature"
		wget http://www.drupal.org/files/projects/feature-${MOD_PV}.tar.gz
		tar xfz feature-${MOD_PV}.tar.gz
		einfo "Unpacking feedback"
		wget http://www.drupal.org/files/projects/feedback-${MOD_PV}.tar.gz
		tar xfz feedback-${MOD_PV}.tar.gz
		einfo "Unpacking filebrowser"
		wget http://www.drupal.org/files/projects/filebrowser-${MOD_PV}.tar.gz
		tar xfz filebrowser-${MOD_PV}.tar.gz
		einfo "Unpacking filemanager"
		wget http://www.drupal.org/files/projects/filemanager-${MOD_PV}.tar.gz
		tar xfz filemanager-${MOD_PV}.tar.gz
		einfo "Unpacking filestore2"
		wget http://www.drupal.org/files/projects/filestore2-${MOD_PV}.tar.gz
		tar xfz filestore2-${MOD_PV}.tar.gz
		einfo "Unpacking flexinode"
		wget http://www.drupal.org/files/projects/flexinode-${MOD_PV}.tar.gz
		tar xfz flexinode-${MOD_PV}.tar.gz
		einfo "Unpacking foaf"
		wget http://www.drupal.org/files/projects/foaf-${MOD_PV}.tar.gz
		tar xfz foaf-${MOD_PV}.tar.gz
		einfo "Unpacking folksonomy"
		wget http://www.drupal.org/files/projects/folksonomy-${MOD_PV}.tar.gz
		tar xfz folksonomy-${MOD_PV}.tar.gz
		einfo "Unpacking fontsize"
		wget http://www.drupal.org/files/projects/fontsize-${MOD_PV}.tar.gz
		tar xfz fontsize-${MOD_PV}.tar.gz
		einfo "Unpacking forms"
		wget http://www.drupal.org/files/projects/forms-${MOD_PV}.tar.gz
		tar xfz forms-${MOD_PV}.tar.gz
		einfo "Unpacking form_mail"
		wget http://www.drupal.org/files/projects/form_mail-${MOD_PV}.tar.gz
		tar xfz form_mail-${MOD_PV}.tar.gz
		einfo "Unpacking front"
		wget http://www.drupal.org/files/projects/front-${MOD_PV}.tar.gz
		tar xfz front-${MOD_PV}.tar.gz
		einfo "Unpacking fscache"
		wget http://www.drupal.org/files/projects/fscache-${MOD_PV}.tar.gz
		tar xfz fscache-${MOD_PV}.tar.gz
		einfo "Unpacking glossary"
		wget http://www.drupal.org/files/projects/glossary-${MOD_PV}.tar.gz
		tar xfz glossary-${MOD_PV}.tar.gz
		einfo "Unpacking guestbook"
		wget http://www.drupal.org/files/projects/guestbook-${MOD_PV}.tar.gz
		tar xfz guestbook-${MOD_PV}.tar.gz
		einfo "Unpacking helpedit"
		wget http://www.drupal.org/files/projects/helpedit-${MOD_PV}.tar.gz
		tar xfz helpedit-${MOD_PV}.tar.gz
		einfo "Unpacking htmlcorrector"
		wget http://www.drupal.org/files/projects/htmlcorrector-${MOD_PV}.tar.gz
		tar xfz htmlcorrector-${MOD_PV}.tar.gz
		einfo "Unpacking htmlarea"
		wget http://www.drupal.org/files/projects/htmlarea-${MOD_PV}.tar.gz
		tar xfz htmlarea-${MOD_PV}.tar.gz
		einfo "Unpacking htmltidy"
		wget http://www.drupal.org/files/projects/htmltidy-${MOD_PV}.tar.gz
		tar xfz htmltidy-${MOD_PV}.tar.gz
		einfo "Unpacking image"
		wget http://www.drupal.org/files/projects/image-${MOD_PV}.tar.gz
		tar xfz image-${MOD_PV}.tar.gz
		einfo "Unpacking image_filter"
		wget http://www.drupal.org/files/projects/image_filter-${MOD_PV}.tar.gz
		tar xfz image_filter-${MOD_PV}.tar.gz
		einfo "Unpacking img_assist"
		wget http://www.drupal.org/files/projects/img_assist-${MOD_PV}.tar.gz
		tar xfz img_assist-${MOD_PV}.tar.gz
		einfo "Unpacking inline"
		wget http://www.drupal.org/files/projects/inline-${MOD_PV}.tar.gz
		tar xfz inline-${MOD_PV}.tar.gz
		einfo "Unpacking im"
		wget http://www.drupal.org/files/projects/im-${MOD_PV}.tar.gz
		tar xfz im-${MOD_PV}.tar.gz
		einfo "Unpacking i18n"
		wget http://www.drupal.org/files/projects/i18n-${MOD_PV}.tar.gz
		tar xfz i18n-${MOD_PV}.tar.gz
		einfo "Unpacking interwiki"
		wget http://www.drupal.org/files/projects/interwiki-${MOD_PV}.tar.gz
		tar xfz interwiki-${MOD_PV}.tar.gz
		einfo "Unpacking jsdomenu"
		wget http://www.drupal.org/files/projects/jsdomenu-${MOD_PV}.tar.gz
		tar xfz jsdomenu-${MOD_PV}.tar.gz
		einfo "Unpacking ldap_integration"
		wget http://www.drupal.org/files/projects/ldap_integration-${MOD_PV}.tar.gz
		tar xfz ldap_integration-${MOD_PV}.tar.gz
		einfo "Unpacking legal"
		wget http://www.drupal.org/files/projects/legal-${MOD_PV}.tar.gz
		tar xfz legal-${MOD_PV}.tar.gz
		einfo "Unpacking listhandler"
		wget http://www.drupal.org/files/projects/listhandler-${MOD_PV}.tar.gz
		tar xfz listhandler-${MOD_PV}.tar.gz
		einfo "Unpacking livediscussions"
		wget http://www.drupal.org/files/projects/livediscussions-${MOD_PV}.tar.gz
		tar xfz livediscussions-${MOD_PV}.tar.gz
		einfo "Unpacking livejournal"
		wget http://www.drupal.org/files/projects/livejournal-${MOD_PV}.tar.gz
		tar xfz livejournal-${MOD_PV}.tar.gz
		einfo "Unpacking mail"
		wget http://www.drupal.org/files/projects/mail-${MOD_PV}.tar.gz
		tar xfz mail-${MOD_PV}.tar.gz
		einfo "Unpacking mailalias"
		wget http://www.drupal.org/files/projects/mailalias-${MOD_PV}.tar.gz
		tar xfz mailalias-${MOD_PV}.tar.gz
		einfo "Unpacking mailhandler"
		wget http://www.drupal.org/files/projects/mailhandler-${MOD_PV}.tar.gz
		tar xfz mailhandler-${MOD_PV}.tar.gz
		einfo "Unpacking marksmarty"
		wget http://www.drupal.org/files/projects/marksmarty-${MOD_PV}.tar.gz
		tar xfz marksmarty-${MOD_PV}.tar.gz
		einfo "Unpacking massmailer"
		wget http://www.drupal.org/files/projects/massmailer-${MOD_PV}.tar.gz
		tar xfz massmailer-${MOD_PV}.tar.gz
		einfo "Unpacking members"
		wget http://www.drupal.org/files/projects/members-${MOD_PV}.tar.gz
		tar xfz members-${MOD_PV}.tar.gz
		einfo "Unpacking menu_otf"
		wget http://www.drupal.org/files/projects/menu_otf-${MOD_PV}.tar.gz
		tar xfz menu_otf-${MOD_PV}.tar.gz
		einfo "Unpacking mypage"
		wget http://www.drupal.org/files/projects/mypage-${MOD_PV}.tar.gz
		tar xfz mypage-${MOD_PV}.tar.gz
		einfo "Unpacking news_page"
		wget http://www.drupal.org/files/projects/news_page-${MOD_PV}.tar.gz
		tar xfz news_page-${MOD_PV}.tar.gz
		einfo "Unpacking nicelinks"
		wget http://www.drupal.org/files/projects/nicelinks-${MOD_PV}.tar.gz
		tar xfz nicelinks-${MOD_PV}.tar.gz
		einfo "Unpacking nodewords"
		wget http://www.drupal.org/files/projects/nodewords-${MOD_PV}.tar.gz
		tar xfz nodewords-${MOD_PV}.tar.gz
		einfo "Unpacking nmoderation"
		wget http://www.drupal.org/files/projects/nmoderation-${MOD_PV}.tar.gz
		tar xfz nmoderation-${MOD_PV}.tar.gz
		einfo "Unpacking node_privacy_byrole"
		wget http://www.drupal.org/files/projects/node_privacy_byrole-${MOD_PV}.tar.gz
		tar xfz node_privacy_byrole-${MOD_PV}.tar.gz
		einfo "Unpacking relativity"
		wget http://www.drupal.org/files/projects/relativity-${MOD_PV}.tar.gz
		tar xfz relativity-${MOD_PV}.tar.gz
		einfo "Unpacking typecat"
		wget http://www.drupal.org/files/projects/typecat-${MOD_PV}.tar.gz
		tar xfz typecat-${MOD_PV}.tar.gz
		einfo "Unpacking node_import"
		wget http://www.drupal.org/files/projects/node_import-${MOD_PV}.tar.gz
		tar xfz node_import-${MOD_PV}.tar.gz
		einfo "Unpacking notify"
		wget http://www.drupal.org/files/projects/notify-${MOD_PV}.tar.gz
		tar xfz notify-${MOD_PV}.tar.gz
		einfo "Unpacking optin"
		wget http://www.drupal.org/files/projects/optin-${MOD_PV}.tar.gz
		tar xfz optin-${MOD_PV}.tar.gz
		einfo "Unpacking og"
		wget http://www.drupal.org/files/projects/og-${MOD_PV}.tar.gz
		tar xfz og-${MOD_PV}.tar.gz
		einfo "Unpacking over_text"
		wget http://www.drupal.org/files/projects/over_text-${MOD_PV}.tar.gz
		tar xfz over_text-${MOD_PV}.tar.gz
		einfo "Unpacking pathauto"
		wget http://www.drupal.org/files/projects/pathauto-${MOD_PV}.tar.gz
		tar xfz pathauto-${MOD_PV}.tar.gz
		einfo "Unpacking paypal_framework"
		wget http://www.drupal.org/files/projects/paypal_framework-${MOD_PV}.tar.gz
		tar xfz paypal_framework-${MOD_PV}.tar.gz
		einfo "Unpacking paypal_subscription"
		wget http://www.drupal.org/files/projects/paypal_subscription-${MOD_PV}.tar.gz
		tar xfz paypal_subscription-${MOD_PV}.tar.gz
		einfo "Unpacking paypal_tipjar"
		wget http://www.drupal.org/files/projects/paypal_tipjar-${MOD_PV}.tar.gz
		tar xfz paypal_tipjar-${MOD_PV}.tar.gz
		einfo "Unpacking pdfview"
		wget http://www.drupal.org/files/projects/pdfview-${MOD_PV}.tar.gz
		tar xfz pdfview-${MOD_PV}.tar.gz
		einfo "Unpacking peoplesemailnetwork"
		wget http://www.drupal.org/files/projects/peoplesemailnetwork-${MOD_PV}.tar.gz
		tar xfz peoplesemailnetwork-${MOD_PV}.tar.gz
		einfo "Unpacking periodical"
		wget http://www.drupal.org/files/projects/periodical-${MOD_PV}.tar.gz
		tar xfz periodical-${MOD_PV}.tar.gz
		einfo "Unpacking poormanscron"
		wget http://www.drupal.org/files/projects/poormanscron-${MOD_PV}.tar.gz
		tar xfz poormanscron-${MOD_PV}.tar.gz
		einfo "Unpacking postcard"
		wget http://www.drupal.org/files/projects/postcard-${MOD_PV}.tar.gz
		tar xfz postcard-${MOD_PV}.tar.gz
		einfo "Unpacking powells"
		wget http://www.drupal.org/files/projects/powells-${MOD_PV}.tar.gz
		tar xfz powells-${MOD_PV}.tar.gz
		einfo "Unpacking print"
		wget http://www.drupal.org/files/projects/print-${MOD_PV}.tar.gz
		tar xfz print-${MOD_PV}.tar.gz
		einfo "Unpacking privatemsg"
		wget http://www.drupal.org/files/projects/privatemsg-${MOD_PV}.tar.gz
		tar xfz privatemsg-${MOD_PV}.tar.gz
		einfo "Unpacking project"
		wget http://www.drupal.org/files/projects/project-${MOD_PV}.tar.gz
		tar xfz project-${MOD_PV}.tar.gz
		einfo "Unpacking pureftp"
		wget http://www.drupal.org/files/projects/pureftp-${MOD_PV}.tar.gz
		tar xfz pureftp-${MOD_PV}.tar.gz
		einfo "Unpacking quickpost"
		wget http://www.drupal.org/files/projects/quickpost-${MOD_PV}.tar.gz
		tar xfz quickpost-${MOD_PV}.tar.gz
		einfo "Unpacking quicktags"
		wget http://www.drupal.org/files/projects/quicktags-${MOD_PV}.tar.gz
		tar xfz quicktags-${MOD_PV}.tar.gz
		einfo "Unpacking quote"
		wget http://www.drupal.org/files/projects/quote-${MOD_PV}.tar.gz
		tar xfz quote-${MOD_PV}.tar.gz
		einfo "Unpacking quotes"
		wget http://www.drupal.org/files/projects/quotes-${MOD_PV}.tar.gz
		tar xfz quotes-${MOD_PV}.tar.gz
		einfo "Unpacking recipe"
		wget http://www.drupal.org/files/projects/recipe-${MOD_PV}.tar.gz
		tar xfz recipe-${MOD_PV}.tar.gz
		einfo "Unpacking relatedlinks"
		wget http://www.drupal.org/files/projects/relatedlinks-${MOD_PV}.tar.gz
		tar xfz relatedlinks-${MOD_PV}.tar.gz
		einfo "Unpacking remindme"
		wget http://www.drupal.org/files/projects/remindme-${MOD_PV}.tar.gz
		tar xfz remindme-${MOD_PV}.tar.gz
		einfo "Unpacking role_to_file"
		wget http://www.drupal.org/files/projects/role_to_file-${MOD_PV}.tar.gz
		tar xfz role_to_file-${MOD_PV}.tar.gz
		einfo "Unpacking rsvp"
		wget http://www.drupal.org/files/projects/rsvp-${MOD_PV}.tar.gz
		tar xfz rsvp-${MOD_PV}.tar.gz
		einfo "Unpacking scheduler"
		wget http://www.drupal.org/files/projects/scheduler-${MOD_PV}.tar.gz
		tar xfz scheduler-${MOD_PV}.tar.gz
		einfo "Unpacking series"
		wget http://www.drupal.org/files/projects/series-${MOD_PV}.tar.gz
		tar xfz series-${MOD_PV}.tar.gz
		einfo "Unpacking sidecontent"
		wget http://www.drupal.org/files/projects/sidecontent-${MOD_PV}.tar.gz
		tar xfz sidecontent-${MOD_PV}.tar.gz
		einfo "Unpacking simpletest"
		wget http://www.drupal.org/files/projects/simpletest-${MOD_PV}.tar.gz
		tar xfz simpletest-${MOD_PV}.tar.gz
		einfo "Unpacking site_map"
		wget http://www.drupal.org/files/projects/site_map-${MOD_PV}.tar.gz
		tar xfz site_map-${MOD_PV}.tar.gz
		einfo "Unpacking sitemenu"
		wget http://www.drupal.org/files/projects/sitemenu-${MOD_PV}.tar.gz
		tar xfz sitemenu-${MOD_PV}.tar.gz
		einfo "Unpacking smartypants"
		wget http://www.drupal.org/files/projects/smartypants-${MOD_PV}.tar.gz
		tar xfz smartypants-${MOD_PV}.tar.gz
		einfo "Unpacking smileys"
		wget http://www.drupal.org/files/projects/smileys-${MOD_PV}.tar.gz
		tar xfz smileys-${MOD_PV}.tar.gz
		einfo "Unpacking spam"
		wget http://www.drupal.org/files/projects/spam-${MOD_PV}.tar.gz
		tar xfz spam-${MOD_PV}.tar.gz
		einfo "Unpacking statistics_filter"
		wget http://www.drupal.org/files/projects/statistics_filter-${MOD_PV}.tar.gz
		tar xfz statistics_filter-${MOD_PV}.tar.gz
		einfo "Unpacking stock"
		wget http://www.drupal.org/files/projects/stock-${MOD_PV}.tar.gz
		tar xfz stock-${MOD_PV}.tar.gz
		einfo "Unpacking subscriptions"
		wget http://www.drupal.org/files/projects/subscriptions-${MOD_PV}.tar.gz
		tar xfz subscriptions-${MOD_PV}.tar.gz
		einfo "Unpacking summary"
		wget http://www.drupal.org/files/projects/summary-${MOD_PV}.tar.gz
		tar xfz summary-${MOD_PV}.tar.gz
		einfo "Unpacking survey"
		wget http://www.drupal.org/files/projects/survey-${MOD_PV}.tar.gz
		tar xfz survey-${MOD_PV}.tar.gz
		einfo "Unpacking swish"
		wget http://www.drupal.org/files/projects/swish-${MOD_PV}.tar.gz
		tar xfz swish-${MOD_PV}.tar.gz
		einfo "Unpacking sxip"
		wget http://www.drupal.org/files/projects/sxip-${MOD_PV}.tar.gz
		tar xfz sxip-${MOD_PV}.tar.gz
		einfo "Unpacking syndication"
		wget http://www.drupal.org/files/projects/syndication-${MOD_PV}.tar.gz
		tar xfz syndication-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_access"
		wget http://www.drupal.org/files/projects/taxonomy_access-${MOD_PV}.tar.gz
		tar xfz taxonomy_access-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_assoc"
		wget http://www.drupal.org/files/projects/taxonomy_assoc-${MOD_PV}.tar.gz
		tar xfz taxonomy_assoc-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_block"
		wget http://www.drupal.org/files/projects/taxonomy_block-${MOD_PV}.tar.gz
		tar xfz taxonomy_block-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_browser"
		wget http://www.drupal.org/files/projects/taxonomy_browser-${MOD_PV}.tar.gz
		tar xfz taxonomy_browser-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_context"
		wget http://www.drupal.org/files/projects/taxonomy_context-${MOD_PV}.tar.gz
		tar xfz taxonomy_context-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_dhtml"
		wget http://www.drupal.org/files/projects/taxonomy_dhtml-${MOD_PV}.tar.gz
		tar xfz taxonomy_dhtml-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_html"
		wget http://www.drupal.org/files/projects/taxonomy_html-${MOD_PV}.tar.gz
		tar xfz taxonomy_html-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_image"
		wget http://www.drupal.org/files/projects/taxonomy_image-${MOD_PV}.tar.gz
		tar xfz taxonomy_image-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_xml"
		wget http://www.drupal.org/files/projects/taxonomy_xml-${MOD_PV}.tar.gz
		tar xfz taxonomy_xml-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_menu"
		wget http://www.drupal.org/files/projects/taxonomy_menu-${MOD_PV}.tar.gz
		tar xfz taxonomy_menu-${MOD_PV}.tar.gz
		einfo "Unpacking taxonomy_otf"
		wget http://www.drupal.org/files/projects/taxonomy_otf-${MOD_PV}.tar.gz
		tar xfz taxonomy_otf-${MOD_PV}.tar.gz
		einfo "Unpacking term_statistics"
		wget http://www.drupal.org/files/projects/term_statistics-${MOD_PV}.tar.gz
		tar xfz term_statistics-${MOD_PV}.tar.gz
		einfo "Unpacking textile"
		wget http://www.drupal.org/files/projects/textile-${MOD_PV}.tar.gz
		tar xfz textile-${MOD_PV}.tar.gz
		einfo "Unpacking theme_editor"
		wget http://www.drupal.org/files/projects/theme_editor-${MOD_PV}.tar.gz
		tar xfz theme_editor-${MOD_PV}.tar.gz
		einfo "Unpacking themedev"
		wget http://www.drupal.org/files/projects/themedev-${MOD_PV}.tar.gz
		tar xfz themedev-${MOD_PV}.tar.gz
		einfo "Unpacking title"
		wget http://www.drupal.org/files/projects/title-${MOD_PV}.tar.gz
		tar xfz title-${MOD_PV}.tar.gz
		einfo "Unpacking trackback"
		wget http://www.drupal.org/files/projects/trackback-${MOD_PV}.tar.gz
		tar xfz trackback-${MOD_PV}.tar.gz
		einfo "Unpacking translation"
		wget http://www.drupal.org/files/projects/translation-${MOD_PV}.tar.gz
		tar xfz translation-${MOD_PV}.tar.gz
		einfo "Unpacking trip_search"
		wget http://www.drupal.org/files/projects/trip_search-${MOD_PV}.tar.gz
		tar xfz trip_search-${MOD_PV}.tar.gz
		einfo "Unpacking troll"
		wget http://www.drupal.org/files/projects/troll-${MOD_PV}.tar.gz
		tar xfz troll-${MOD_PV}.tar.gz
		einfo "Unpacking urlfilter"
		wget http://www.drupal.org/files/projects/urlfilter-${MOD_PV}.tar.gz
		tar xfz urlfilter-${MOD_PV}.tar.gz
		einfo "Unpacking userposts"
		wget http://www.drupal.org/files/projects/userposts-${MOD_PV}.tar.gz
		tar xfz userposts-${MOD_PV}.tar.gz
		einfo "Unpacking validation"
		wget http://www.drupal.org/files/projects/validation-${MOD_PV}.tar.gz
		tar xfz validation-${MOD_PV}.tar.gz
		einfo "Unpacking variable"
		wget http://www.drupal.org/files/projects/variable-${MOD_PV}.tar.gz
		tar xfz variable-${MOD_PV}.tar.gz
		einfo "Unpacking volunteer"
		wget http://www.drupal.org/files/projects/volunteer-${MOD_PV}.tar.gz
		tar xfz volunteer-${MOD_PV}.tar.gz
		einfo "Unpacking weather"
		wget http://www.drupal.org/files/projects/weather-${MOD_PV}.tar.gz
		tar xfz weather-${MOD_PV}.tar.gz
		einfo "Unpacking webform"
		wget http://www.drupal.org/files/projects/webform-${MOD_PV}.tar.gz
		tar xfz webform-${MOD_PV}.tar.gz
		einfo "Unpacking weblink"
		wget http://www.drupal.org/files/projects/weblink-${MOD_PV}.tar.gz
		tar xfz weblink-${MOD_PV}.tar.gz
		einfo "Unpacking webserver_auth"
		wget http://www.drupal.org/files/projects/webserver_auth-${MOD_PV}.tar.gz
		tar xfz webserver_auth-${MOD_PV}.tar.gz
		einfo "Unpacking week"
		wget http://www.drupal.org/files/projects/week-${MOD_PV}.tar.gz
		tar xfz week-${MOD_PV}.tar.gz
		einfo "Unpacking wiki"
		wget http://www.drupal.org/files/projects/wiki-${MOD_PV}.tar.gz
		tar xfz wiki-${MOD_PV}.tar.gz
		einfo "Unpacking workflow"
		wget http://www.drupal.org/files/projects/workflow-${MOD_PV}.tar.gz
		tar xfz workflow-${MOD_PV}.tar.gz
		einfo "Unpacking workspace"
		wget http://www.drupal.org/files/projects/workspace-${MOD_PV}.tar.gz
		tar xfz workspace-${MOD_PV}.tar.gz
		einfo "Unpacking ystock"
		wget http://www.drupal.org/files/projects/ystock-${MOD_PV}.tar.gz
		tar xfz ystock-${MOD_PV}.tar.gz

		cd ${S}/themes
		einfo "Unpacking adc"
		wget http://www.drupal.org/files/projects/adc-${MOD_PV}.tar.gz
		tar xfz adc-${MOD_PV}.tar.gz
		einfo "Unpacking box_grey_smarty"
		wget http://www.drupal.org/files/projects/box_grey_smarty-${MOD_PV}.tar.gz
		tar xfz box_grey_smarty-${MOD_PV}.tar.gz
		einfo "Unpacking box_grey"
		wget http://www.drupal.org/files/projects/box_grey-${MOD_PV}.tar.gz
		tar xfz box_grey-${MOD_PV}.tar.gz
		einfo "Unpacking democratica"
		wget http://www.drupal.org/files/projects/democratica-${MOD_PV}.tar.gz
		tar xfz democratica-${MOD_PV}.tar.gz
		einfo "Unpacking friendselectric"
		wget http://www.drupal.org/files/projects/friendselectric-${MOD_PV}.tar.gz
		tar xfz friendselectric-${MOD_PV}.tar.gz
		einfo "Unpacking goofy"
		wget http://www.drupal.org/files/projects/goofy-${MOD_PV}.tar.gz
		tar xfz goofy-${MOD_PV}.tar.gz
		einfo "Unpacking interlaced"
		wget http://www.drupal.org/files/projects/interlaced-${MOD_PV}.tar.gz
		tar xfz interlaced-${MOD_PV}.tar.gz
		einfo "Unpacking kubrick"
		wget http://www.drupal.org/files/projects/kubrick-${MOD_PV}.tar.gz
		tar xfz kubrick-${MOD_PV}.tar.gz
		einfo "Unpacking lincolns_revenge"
		wget http://www.drupal.org/files/projects/lincolns_revenge-${MOD_PV}.tar.gz
		tar xfz lincolns_revenge-${MOD_PV}.tar.gz
		einfo "Unpacking manji"
		wget http://www.drupal.org/files/projects/manji-${MOD_PV}.tar.gz
		tar xfz manji-${MOD_PV}.tar.gz
		einfo "Unpacking marvin_2k_phptemplate"
		wget http://www.drupal.org/files/projects/marvin_2k_phptemplate-${MOD_PV}.tar.gz
		tar xfz marvin_2k_phptemplate-${MOD_PV}.tar.gz
		einfo "Unpacking persian"
		wget http://www.drupal.org/files/projects/persian-${MOD_PV}.tar.gz
		tar xfz persian-${MOD_PV}.tar.gz
		einfo "Unpacking pushbutton_phptemplate"
		wget http://www.drupal.org/files/projects/pushbutton_phptemplate-${MOD_PV}.tar.gz
		tar xfz pushbutton_phptemplate-${MOD_PV}.tar.gz
		einfo "Unpacking spreadfirefox"
		wget http://www.drupal.org/files/projects/spreadfirefox-${MOD_PV}.tar.gz
		tar xfz spreadfirefox-${MOD_PV}.tar.gz
		einfo "Unpacking sunflower"
		wget http://www.drupal.org/files/projects/sunflower-${MOD_PV}.tar.gz
		tar xfz sunflower-${MOD_PV}.tar.gz

		cd ${S}
		einfo "Unpacking sq"
		wget http://www.drupal.org/files/projects/sq-${MOD_PV}.tar.gz
		tar xfz sq-${MOD_PV}.tar.gz
		einfo "Unpacking ar"
		wget http://www.drupal.org/files/projects/ar-${MOD_PV}.tar.gz
		tar xfz ar-${MOD_PV}.tar.gz
		einfo "Unpacking eu"
		wget http://www.drupal.org/files/projects/eu-${MOD_PV}.tar.gz
		tar xfz eu-${MOD_PV}.tar.gz
		einfo "Unpacking pt-br"
		wget http://www.drupal.org/files/projects/pt-br-${MOD_PV}.tar.gz
		tar xfz pt-br-${MOD_PV}.tar.gz
		einfo "Unpacking ca"
		wget http://www.drupal.org/files/projects/ca-${MOD_PV}.tar.gz
		tar xfz ca-${MOD_PV}.tar.gz
		einfo "Unpacking zh-hans"
		wget http://www.drupal.org/files/projects/zh-hans-${MOD_PV}.tar.gz
		tar xfz zh-hans-${MOD_PV}.tar.gz
		einfo "Unpacking cs"
		wget http://www.drupal.org/files/projects/cs-${MOD_PV}.tar.gz
		tar xfz cs-${MOD_PV}.tar.gz
		einfo "Unpacking da"
		wget http://www.drupal.org/files/projects/da-${MOD_PV}.tar.gz
		tar xfz da-${MOD_PV}.tar.gz
		einfo "Unpacking nl"
		wget http://www.drupal.org/files/projects/nl-${MOD_PV}.tar.gz
		tar xfz nl-${MOD_PV}.tar.gz
		einfo "Unpacking eo"
		wget http://www.drupal.org/files/projects/eo-${MOD_PV}.tar.gz
		tar xfz eo-${MOD_PV}.tar.gz
		einfo "Unpacking fr"
		wget http://www.drupal.org/files/projects/fr-${MOD_PV}.tar.gz
		tar xfz fr-${MOD_PV}.tar.gz
		einfo "Unpacking de"
		wget http://www.drupal.org/files/projects/de-${MOD_PV}.tar.gz
		tar xfz de-${MOD_PV}.tar.gz
		einfo "Unpacking hu"
		wget http://www.drupal.org/files/projects/hu-${MOD_PV}.tar.gz
		tar xfz hu-${MOD_PV}.tar.gz
		einfo "Unpacking id"
		wget http://www.drupal.org/files/projects/id-${MOD_PV}.tar.gz
		tar xfz id-${MOD_PV}.tar.gz
		einfo "Unpacking it"
		wget http://www.drupal.org/files/projects/it-${MOD_PV}.tar.gz
		tar xfz it-${MOD_PV}.tar.gz
		einfo "Unpacking ja"
		wget http://www.drupal.org/files/projects/ja-${MOD_PV}.tar.gz
		tar xfz ja-${MOD_PV}.tar.gz
		einfo "Unpacking nno"
		wget http://www.drupal.org/files/projects/nno-${MOD_PV}.tar.gz
		tar xfz nno-${MOD_PV}.tar.gz
		einfo "Unpacking pl"
		wget http://www.drupal.org/files/projects/pl-${MOD_PV}.tar.gz
		tar xfz pl-${MOD_PV}.tar.gz
		einfo "Unpacking pt-pt"
		wget http://www.drupal.org/files/projects/pt-pt-${MOD_PV}.tar.gz
		tar xfz pt-pt-${MOD_PV}.tar.gz
		einfo "Unpacking ro"
		wget http://www.drupal.org/files/projects/ro-${MOD_PV}.tar.gz
		tar xfz ro-${MOD_PV}.tar.gz
		einfo "Unpacking ru"
		wget http://www.drupal.org/files/projects/ru-${MOD_PV}.tar.gz
		tar xfz ru-${MOD_PV}.tar.gz
		einfo "Unpacking sv"
		wget http://www.drupal.org/files/projects/sv-${MOD_PV}.tar.gz
		tar xfz sv-${MOD_PV}.tar.gz
		einfo "Unpacking drupal-pot"
		wget http://www.drupal.org/files/projects/drupal-pot-${MOD_PV}.tar.gz
		tar xfz drupal-pot-${MOD_PV}.tar.gz

		cd ${S}/themes/engines
		einfo "Unpacking phptemplate"
		wget http://www.drupal.org/files/projects/phptemplate-${MOD_PV}.tar.gz
		tar xfz phptemplate-${MOD_PV}.tar.gz
		einfo "Unpacking smarty"
		wget http://www.drupal.org/files/projects/smarty-${MOD_PV}.tar.gz
		tar xfz smarty-${MOD_PV}.tar.gz

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

	webapp_configfile ${MY_HTDOCSDIR}/includes/conf.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
