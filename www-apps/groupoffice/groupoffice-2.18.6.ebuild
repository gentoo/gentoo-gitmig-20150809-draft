# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/groupoffice/groupoffice-2.18.6.ebuild,v 1.5 2012/09/30 18:43:13 armin76 Exp $

inherit eutils webapp depend.php versionator

MY_PV=$(get_version_component_range 1-2)
MY_PV1=$(get_version_component_range 3-4)

S=${WORKDIR}/${PN}-com-${MY_PV}-stable-${MY_PV1}
DESCRIPTION="Group-Office is a powerful modular Intranet application framework"
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${PN}-com-${MY_PV}-stable-${MY_PV1}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-arch/zip
		 app-arch/unzip
		 virtual/httpd-cgi"

need_php

pkg_setup() {
	webapp_pkg_setup
	elog "PHP needs to be compiled with iconv support"
	elog "If you are using php-5*, be sure it's compiled with USE=iconv"
	require_php_with_use imap mysql calendar
}

src_install() {
	webapp_src_preinst

	local docs="CHANGELOG DEVELOPERS FAQ README README.ldap TODO TRANSLATORS"

	dodoc ${docs} RELEASE LICENSE.*

	cp -r . "${D}${MY_HTDOCSDIR}"
	for doc in ${docs}; do
		rm -f "${D}${MY_HTDOCSDIR}/${doc}"
	done

	touch "${D}${MY_HTDOCSDIR}"/config.php
	dodir "${MY_HOSTROOTDIR}/${P}"/userdata "${MY_HTDOCSDIR}"/local

	webapp_serverowned "${MY_HTDOCSDIR}"
	webapp_serverowned -R "${MY_HOSTROOTDIR}/${P}"/userdata
	webapp_serverowned "${MY_HTDOCSDIR}"/local
	webapp_configfile "${MY_HTDOCSDIR}"/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall2-en.txt
	webapp_src_install
}
