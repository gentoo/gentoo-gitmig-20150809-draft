# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-2.0.20.ebuild,v 1.1 2006/04/20 17:05:14 rl03 Exp $

inherit webapp

DESCRIPTION="phpBB is an open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="http://www.phpbb.com/files/releases/${P}.tar.bz2
		mirror://sourceforge/phpbb/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

RDEPEND="virtual/httpd-php"

S=${WORKDIR}/${PN}2

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*

	cp -pPR * "${D}/${MY_HTDOCSDIR}"
	rm -rf ${D}/${MY_HTDOCSDIR}/docs

	echo "<?php trigger_error('Please use install/install.php to configure phpBB for your system!', E_USER_ERROR); ?>" > "${D}/${MY_HTDOCSDIR}/config.php"
	webapp_serverowned "${MY_HTDOCSDIR}/config.php"
	webapp_serverowned ${MY_HTDOCSDIR}/images
	webapp_serverowned ${MY_HTDOCSDIR}/images/avatars
	webapp_serverowned ${MY_HTDOCSDIR}/images/avatars/gallery
	webapp_serverowned ${MY_HTDOCSDIR}/language
	webapp_serverowned ${MY_HTDOCSDIR}/templates

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
