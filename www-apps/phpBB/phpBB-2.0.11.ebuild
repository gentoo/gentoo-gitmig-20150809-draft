# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-2.0.11.ebuild,v 1.2 2004/11/24 04:14:47 klieber Exp $

inherit webapp

DESCRIPTION="phpBB is an open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="mirror://sourceforge/phpbb/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~amd64"

RDEPEND="virtual/php"

S=${WORKDIR}/${PN}2

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*
	rm -rf ${S}/docs/

	cp -a * "${D}/${MY_HTDOCSDIR}"

	echo "<?php trigger_error('Please use install/install.php to configure phpBB for your system!', E_USER_ERROR); ?>" > "${D}/${MY_HTDOCSDIR}/config.php"
	webapp_serverowned "${MY_HTDOCSDIR}/config.php"

	webapp_postinst_txt en ${FILESDIR}/2.0.10-postinstall-en.txt

	webapp_src_install
}
