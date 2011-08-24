# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwiki/phpwiki-1.4.0_rc1.ebuild,v 1.2 2011/08/24 07:23:09 olemarkus Exp $

EAPI=4

inherit webapp

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PhpWiki is a WikiWikiWeb clone in PHP"
HOMEPAGE="http://phpwiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mysql postgres"

RDEPEND="
	virtual/httpd-cgi
	dev-lang/php[mysql?,postgres?]
	|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	|| ( dev-lang/php[cgi] dev-lang/php[apache2] )"

src_prepare() {
	rm -f Makefile LICENSE
}

src_install() {
	webapp_src_preinst

	cp -pPR * "${D}/${MY_HTDOCSDIR}"
	rm -rf "${D}/${MY_HTDOCSDIR}"/{doc,schemas,README,INSTALL,TODO,UPGRADING}

	dodoc README INSTALL TODO UPGRADING doc/* schemas/*

	# Create config file from distribution default, and fix up invalid defaults
	sed -ie "s:;DEBUG = 1:DEBUG = 0:" "${D}/${MY_HTDOCSDIR}"/config/config-dist.ini
	cd "${D}"/${MY_HTDOCSDIR}/config
	cp config-dist.ini config.ini

	webapp_postinst_txt en "${FILESDIR}"/postinstall-1.3-en.txt
	webapp_configfile "${MY_HTDOCSDIR}"/config/config.ini

	webapp_src_install
}
