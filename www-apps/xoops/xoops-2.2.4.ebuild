# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xoops/xoops-2.2.4.ebuild,v 1.1 2006/04/23 22:34:25 rl03 Exp $

inherit webapp

DESCRIPTION="eXtensible Object Oriented Portal System (xoops) is an open-source Content Management System, including various portal features and supplemental modules."
HOMEPAGE="http://www.xoops.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-2.2.3a-Final.tar.gz
mirror://sourceforge/${PN}/xoops-2.2.3a-to-2.2.4.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
S=${WORKDIR}

IUSE="mysql"

RDEPEND="virtual/php
	net-www/apache
	mysql? ( dev-db/mysql )"

src_unpack() {
	unpack ${A} && cd ${S}
	cp -f xoops-2.2.3a-to-2.2.4/docs/* docs/ || die
	cp -Rf xoops-2.2.3a-to-2.2.4/html/* html/ || die
}


src_install() {
	webapp_src_preinst
	dodir ${MY_HOSTROOTDIR}/${PF}
	dodoc docs/changelog.txt
	dohtml docs/INSTALL.html docs/UPDATE.html
	cp -R docs/images ${D}/usr/share/doc/${PF}/html

	cp -pPR html/* "${D}/${MY_HTDOCSDIR}"
	cp -pPR extras/* ${D}/${MY_HOSTROOTDIR}/${PF}
	webapp_serverowned ${MY_HTDOCSDIR}/uploads
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/templates_c
	webapp_configfile ${MY_HTDOCSDIR}/mainfile.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
