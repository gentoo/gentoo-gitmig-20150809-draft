# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-9999.ebuild,v 1.1 2010/02/21 17:38:21 reavertm Exp $

EAPI="2"

inherit webapp depend.php git

DESCRIPTION="Web-based administration for Postgres database in php"
HOMEPAGE="http://phppgadmin.sourceforge.net/"
EGIT_REPO_URI="git://github.com/xzilla/phppgadmin.git"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

need_php

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use pcre postgres session
}

src_install() {
	webapp_src_preinst

	local doc
	local docs="CREDITS DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS"
	dodoc ${docs}
	mv conf/config.inc.php-dist conf/config.inc.php

	cp -r * "${D}"${MY_HTDOCSDIR}
	for doc in ${docs} INSTALL LICENSE; do
		rm -f "${D}"${MY_HTDOCSDIR}/${doc}
	done

	webapp_configfile ${MY_HTDOCSDIR}/conf/config.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
