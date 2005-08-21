# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/groupoffice/groupoffice-2.13.ebuild,v 1.2 2005/08/21 17:20:15 rl03 Exp $

inherit eutils webapp

S=${WORKDIR}/${PN}-com-${PV}
DESCRIPTION="Group-Office is a powerful modular Intranet application framework. It runs *nix using PHP and has several database support."
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${PN}-com-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc"
IUSE=""
DEPEND="virtual/php
	>=dev-db/mysql-4.0
	net-www/apache"

pkg_setup() {
	webapp_pkg_setup
	einfo "PHP needs to be compiled with iconv support"
	einfo "If you are using php-4*, be sure it's compiled with USE=nls"
	einfo "If you are using php-5*, be sure it's compiled with USE=iconv"
	if ! built_with_use virtual/php imap mysql; then
		ewarn "PHP needs to be compiled with IMAP and MySQL support."
		die "Recompile php with USE=\"imap mysql\""
	fi
}

src_install() {
	webapp_src_preinst

	local docs="CHANGELOG DEVELOPERS FAQ README README.ldap TODO TRANSLATORS"

	dodoc ${docs} RELEASE

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
