# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpBB/phpBB-3.0.7_p1.ebuild,v 1.1 2010/08/21 10:48:49 a3li Exp $

inherit webapp depend.php

MY_PV=${PV/_p/-PL}

DESCRIPTION="phpBB is an open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="mirror://sourceforge/phpbb/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${PN}3

src_install() {
	webapp_src_preinst

	dodoc docs/*
	rm -rf docs

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/cache
	webapp_serverowned "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/images/avatars/upload
	webapp_serverowned "${MY_HTDOCSDIR}"/store
	webapp_serverowned "${MY_HTDOCSDIR}"/config.php
	webapp_configfile  "${MY_HTDOCSDIR}"/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
