# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.3.14.ebuild,v 1.3 2008/02/04 08:30:59 hollow Exp $

inherit webapp depend.php

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE="msql mysql postgres"

RDEPEND="virtual/httpd-cgi"
need_php

pkg_setup() {
	local flags="pcre"
	for f in msql mysql postgres ; do
		use ${f} && flags="${flags} ${f}"
	done
	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} || \
		! PHPCHECKNODIE="yes" require_php_with_any_use apache2 cgi ; then
			die "Re-install ${PHP_PKG} with ${flags} and at least one of apache2 or cgi."
	fi
	webapp_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile LICENSE
}

src_install() {
	webapp_src_preinst

	cp -pPR * "${D}/${MY_HTDOCSDIR}"
	rm -rf "${D}/${MY_HTDOCSDIR}"/{doc,schemas,README,INSTALL,TODO,UPGRADING}

	dodoc README INSTALL TODO UPGRADING doc/* schemas/*

	# Create config file from distribution default, and fix up invalid defaults
	dosed "s:;DEBUG = 1:DEBUG = 0:" "${MY_HTDOCSDIR}"/config/config-dist.ini
	cd "${D}"/${MY_HTDOCSDIR}/config
	cp config-dist.ini config.ini

	webapp_postinst_txt en "${FILESDIR}"/postinstall-1.3-en.txt
	webapp_configfile "${MY_HTDOCSDIR}"/config/config.ini

	webapp_src_install
}
