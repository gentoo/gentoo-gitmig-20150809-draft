# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xoops/xoops-2.0.7.3.ebuild,v 1.2 2004/10/18 12:32:56 dholm Exp $

inherit webapp

DESCRIPTION="eXtensible Object Oriented Portal System (xoops) is an open-source Content Management System, including various portal features and supplemental modules."
HOMEPAGE="http://www.xoops.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=virtual/php-4.1.1
	net-www/apache
	>=dev-db/mysql-3.23"

S=${WORKDIR}/${P}/${P}

src_install() {
	webapp_src_preinst
	dodoc docs/CHANGES.txt
	dohtml docs/INSTALL.html
	mv docs/images ${D}/usr/share/doc/${PF}/html

	cp -a html/* "${D}/${MY_HTDOCSDIR}"
	webapp_serverowned ${MY_HTDOCSDIR}/uploads
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/templates_c
	webapp_serverowned ${MY_HTDOCSDIR}/mainfile.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
