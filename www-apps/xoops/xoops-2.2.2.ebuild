# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xoops/xoops-2.2.2.ebuild,v 1.1 2005/08/16 19:35:37 rl03 Exp $

inherit webapp

DESCRIPTION="eXtensible Object Oriented Portal System (xoops) is an open-source Content Management System, including various portal features and supplemental modules."
HOMEPAGE="http://www.xoops.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="virtual/php
	net-www/apache
	>=dev-db/mysql-3.23"

src_install() {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${P}
	dodoc changelog.txt
	dohtml docs/INSTALL.html UPDATE.html
	cp -R docs/images ${D}/usr/share/doc/${PF}/html

	cp -a html/* "${D}/${MY_HTDOCSDIR}"
	cp -a extras/* ${D}/${MY_HOSTROOTDIR}/${P}
	webapp_serverowned ${MY_HTDOCSDIR}/uploads
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/templates_c
	webapp_configfile ${MY_HTDOCSDIR}/mainfile.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
