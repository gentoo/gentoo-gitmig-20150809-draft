# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xoops/xoops-2.3.3.ebuild,v 1.1 2009/08/13 12:25:15 a3li Exp $

inherit webapp depend.php

DESCRIPTION="eXtensible Object Oriented Portal System (xoops) is an open-source
Content Management System, including various portal features and supplemental modules."
HOMEPAGE="http://www.xoops.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

need_httpd_cgi
need_php_httpd

pkg_setup() {
	if ! PHPCHECKNODIE="yes" require_php_with_use mysql || \
		! PHPCHECKNODIE="yes" require_php_with_any_use apache2 cgi ; then
			die "Re-install ${PHP_PKG} with mysql and at least one of apache2 or cgi flags."
	fi
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	dodir ${MY_HOSTROOTDIR}/${PF}
	dodoc docs/changelog.txt
	dohtml docs/INSTALL.html docs/UPDATE.html

	cp -R docs/images "${D}"/usr/share/doc/${PF}/html
	cp -pPR htdocs/* "${D}/${MY_HTDOCSDIR}"
	cp -pPR extras/* "${D}"/${MY_HOSTROOTDIR}/${PF}

	webapp_serverowned ${MY_HTDOCSDIR}/uploads
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/templates_c
	webapp_configfile ${MY_HTDOCSDIR}/mainfile.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
