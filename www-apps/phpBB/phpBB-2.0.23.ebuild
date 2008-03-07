# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-2.0.23.ebuild,v 1.1 2008/03/07 12:33:54 hollow Exp $

inherit webapp depend.php

DESCRIPTION="phpBB is an open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="http://www.phpbb.com/files/releases/${P}.tar.bz2
		mirror://sourceforge/phpbb/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${PN}2

src_install() {
	webapp_src_preinst

	dodoc docs/*
	rm -rf docs

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/images
	webapp_serverowned "${MY_HTDOCSDIR}"/images/avatars
	webapp_serverowned "${MY_HTDOCSDIR}"/images/avatars/gallery
	webapp_serverowned "${MY_HTDOCSDIR}"/language
	webapp_serverowned "${MY_HTDOCSDIR}"/templates
	webapp_serverowned "${MY_HTDOCSDIR}"/config.php
	webapp_configfile  "${MY_HTDOCSDIR}"/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
