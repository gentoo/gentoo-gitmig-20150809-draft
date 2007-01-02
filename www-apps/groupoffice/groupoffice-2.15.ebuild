# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/groupoffice/groupoffice-2.15.ebuild,v 1.5 2007/01/02 22:32:10 rl03 Exp $

inherit eutils webapp depend.php

S=${WORKDIR}/${PN}-com-${PV}
DESCRIPTION="Group-Office is a powerful modular Intranet application framework"
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${PN}-com-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ppc ~sparc ~x86"
IUSE=""

need_php

pkg_setup() {
	webapp_pkg_setup
	elog "PHP needs to be compiled with iconv support"
	elog "If you are using php-4*, be sure it's compiled with USE=nls"
	elog "If you are using php-5*, be sure it's compiled with USE=iconv"
	require_php_with_use imap mysql
}

src_install() {
	webapp_src_preinst

	local docs="CHANGELOG DEVELOPERS FAQ README README.ldap TODO TRANSLATORS"

	dodoc ${docs} RELEASE LICENSE.PRO

	cp -r . ${D}${MY_HTDOCSDIR}
	for doc in ${docs}; do
		rm -f ${D}${MY_HTDOCSDIR}/${doc}
	done

	touch ${D}${MY_HTDOCSDIR}/config.php
	dodir ${MY_HOSTROOTDIR}/${P}/userdata ${MY_HTDOCSDIR}/local

	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HOSTROOTDIR}/${P}/userdata
	webapp_serverowned ${MY_HTDOCSDIR}/local
	webapp_configfile ${MY_HTDOCSDIR}/config.php

	webapp_postinst_txt en ${FILESDIR}/postinstall2-en.txt
	webapp_src_install
}
