# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-3.0.0.ebuild,v 1.1 2008/01/25 08:06:29 wrobel Exp $

inherit webapp

DESCRIPTION="phpBB is an open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="http://www.phpbb.com/files/releases/${P}.tar.bz2
		mirror://sourceforge/phpbb/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

RDEPEND="virtual/httpd-php
	virtual/httpd-cgi"

S=${WORKDIR}/${PN}3

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*

	cp -pPR * "${D}/${MY_HTDOCSDIR}"
	rm -rf "${D}/${MY_HTDOCSDIR}/docs"

	webapp_serverowned "${MY_HTDOCSDIR}/config.php"
	webapp_serverowned "${MY_HTDOCSDIR}/cache"
	webapp_serverowned "${MY_HTDOCSDIR}/files"
	webapp_serverowned "${MY_HTDOCSDIR}/images/avatars/upload"
	webapp_serverowned "${MY_HTDOCSDIR}/store"

	webapp_configfile  "${MY_HTDOCSDIR}/config.php"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"

	webapp_src_install
}
