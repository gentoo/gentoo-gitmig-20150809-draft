# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/roundcube/roundcube-0.4.2.ebuild,v 1.6 2011/03/24 06:59:00 radhermit Exp $

EAPI="2"

MY_PN="${PN}mail"
MY_P="${MY_PN}-${PV}"

inherit webapp depend.php depend.apache

DESCRIPTION="A browser-based multilingual IMAP client with an application-like user interface"
HOMEPAGE="http://roundcube.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

# roundcube is GPL-licensed, the rest of the licenses here are
# for bundled PEAR components, googiespell and utf8.class.php
LICENSE="GPL-2 BSD PHP-2.02 PHP-3 MIT public-domain"
KEYWORDS="amd64 arm ppc ppc64 ~sparc x86"
IUSE="ldap mysql postgres ssl spell"

DEPEND=""
RDEPEND="|| ( <dev-lang/php-5.3[crypt,iconv,json,ldap?,pcre,postgres?,session,spl,ssl?,unicode]
		>=dev-lang/php-5.3[crypt,iconv,json,ldap?,postgres?,session,ssl?,unicode] )
	!postgres? ( !mysql? ( dev-lang/php[sqlite] ) )
	spell? ( dev-lang/php[curl,spell] )
	dev-php/PEAR-PEAR"

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use mysql && require_php_with_any_use mysql mysqli

	# add some warnings about optional functionality
	if ! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external; then
		ewarn "IMAP quota display will not work correctly without GD support in PHP."
		ewarn "Recompile PHP with either gd or gd-external in USE if you want this feature."
		ewarn
	fi

	webapp_pkg_setup
}

src_prepare() {
	cp config/db.inc.php{.dist,}
	cp config/main.inc.php{.dist,}
}

src_install () {
	webapp_src_preinst
	dodoc CHANGELOG INSTALL README UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r [[:lower:]]* SQL
	doins .htaccess

	webapp_serverowned "${MY_HTDOCSDIR}"/logs
	webapp_serverowned "${MY_HTDOCSDIR}"/temp

	webapp_configfile "${MY_HTDOCSDIR}"/config/{db,main}.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en UPGRADING
	webapp_src_install
}
