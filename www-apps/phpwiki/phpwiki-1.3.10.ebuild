# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.3.10.ebuild,v 1.1 2004/09/08 12:23:16 rl03 Exp $

inherit webapp

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=virtual/php-4.0.6
	net-www/apache"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f Makefile LICENSE
}

src_install() {
	webapp_src_preinst

	cp -a * ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/{doc,schemas,README,INSTALL,UPGRADING}

	dodoc README INSTALL UPGRADING doc/* schemas/*

	# Create config file from distribution default, and fix up invalid defaults
	cd ${D}/${MY_HTDOCSDIR}/config
	sed "s:;DEBUG = 1:DEBUG = 0:" config-dist.ini > config.ini

	webapp_postinst_txt en ${FILESDIR}/postinstall-1.3-en.txt
	webapp_configfile ${MY_HTDOCSDIR}/config/config.ini

	webapp_src_install
}
