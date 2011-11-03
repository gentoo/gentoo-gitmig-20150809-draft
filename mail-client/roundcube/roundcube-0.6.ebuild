# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/roundcube/roundcube-0.6.ebuild,v 1.2 2011/11/03 11:43:44 chainsaw Exp $

EAPI="2"

inherit webapp depend.php

MY_PN="${PN}mail"
MY_P="${MY_PN}-${PV/_/-}"
DESCRIPTION="A browser-based multilingual IMAP client with an application-like user interface"
HOMEPAGE="http://roundcube.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

# roundcube is GPL-licensed, the rest of the licenses here are
# for bundled PEAR components, googiespell and utf8.class.php
LICENSE="GPL-2 BSD PHP-2.02 PHP-3 MIT public-domain"
KEYWORDS="amd64 ~x86"
IUSE="ldap mysql postgres ssl spell +sqlite"

DEPEND=""
RDEPEND=">=dev-lang/php-5.3[crypt,iconv,json,ldap?,postgres?,session,sqlite?,sockets,ssl?,xml,unicode]
	spell? ( dev-lang/php[curl,spell] )
	>=dev-php/PEAR-MDB2-2.5.0_beta3
	>=dev-php/PEAR-Mail_Mime-1.8.1
	>=dev-php/PEAR-Net_SMTP-1.4.2
	>=dev-php/PEAR-Net_IDNA2-0.1.1
	>=dev-php/PEAR-Auth_SASL-1.0.3"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	webapp_pkg_setup

	use mysql && require_php_with_any_use mysql mysqli

	# add some warnings about optional functionality
	if ! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external; then
		ewarn "IMAP quota display will not work correctly without GD support in PHP."
		ewarn "Recompile PHP with either gd or gd-external in USE if you want this feature."
		ewarn
	fi
}

src_prepare() {
	cp config/db.inc.php{.dist,} || die
	cp config/main.inc.php{.dist,} || die
}

src_install() {
	webapp_src_preinst
	dodoc CHANGELOG INSTALL README UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r [[:lower:]]* SQL
	doins .htaccess

	webapp_serverowned "${MY_HTDOCSDIR}"/logs
	webapp_serverowned "${MY_HTDOCSDIR}"/temp

	webapp_configfile "${MY_HTDOCSDIR}"/config/{db,main}.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-0.6.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en-0.6.txt
	webapp_postupgrade_txt en UPGRADING
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	ewarn "When upgrading from version older than 0.6-beta you should make sure your"
	ewarn "folder settings contain namespace prefix. For example Courier users should"
	ewarn "add INBOX. prefix to folder names in main configuration file."
}
