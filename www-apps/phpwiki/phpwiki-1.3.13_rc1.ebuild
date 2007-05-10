# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.3.13_rc1.ebuild,v 1.1 2007/05/10 12:57:53 wrobel Exp $

inherit webapp depend.php

MY_P=${P/_r/r}
S=${WORKDIR}/${PN}-${PV/_rc*/}

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/php
	net-www/apache"

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

	# Fix for security issue (Gentoo bug #174451 and http://secunia.com/advisories/24888/)
	rm -rf ${D}/${MY_HTDOCSDIR}/lib/plugin/UpLoad.php

	dodoc README INSTALL TODO UPGRADING doc/* schemas/*

	# Create config file from distribution default, and fix up invalid defaults
	cd ${D}/${MY_HTDOCSDIR}/config
	sed "s:;DEBUG = 1:DEBUG = 0:" config-dist.ini > config.ini

	webapp_postinst_txt en ${FILESDIR}/postinstall-1.3-en.txt
	webapp_configfile ${MY_HTDOCSDIR}/config/config.ini

	webapp_src_install
}
