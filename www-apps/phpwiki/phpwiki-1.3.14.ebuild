# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.3.14.ebuild,v 1.2 2007/08/14 18:13:04 dertobi123 Exp $

inherit webapp depend.php

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/php
	www-servers/apache"

src_unpack() {
	require_php_with_use pcre

	unpack ${A}
	cd ${S}
	rm -f Makefile LICENSE
}

src_install() {
	webapp_src_preinst

	cp -pPR * ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/{doc,schemas,README,INSTALL,TODO,UPGRADING}

	dodoc README INSTALL TODO UPGRADING doc/* schemas/*

	# Create config file from distribution default, and fix up invalid defaults
	cd ${D}/${MY_HTDOCSDIR}/config
	sed "s:;DEBUG = 1:DEBUG = 0:" config-dist.ini > config.ini

	webapp_postinst_txt en ${FILESDIR}/postinstall-1.3-en.txt
	webapp_configfile ${MY_HTDOCSDIR}/config/config.ini

	webapp_src_install
}
