# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/back-end/back-end-0.7.1.2.ebuild,v 1.3 2004/09/02 13:37:53 dholm Exp $

inherit webapp

S=${WORKDIR}/${PN}${PV}

IUSE="ldap"

DESCRIPTION="Back-End is a multilingual Web publishing/content management system"
HOMEPAGE="http://back-end.org/"
SRC_URI="mirror://sourceforge//${PN}/${PN}${PV}.tar.gz"

KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=virtual/php-4.1
	>=net-www/apache-1.3
	>=dev-db/mysql-3.23
	ldap? ( net-nds/openldap )
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f Makefile
}

src_install() {
	webapp_src_preinst
	local file

	dodoc ABOUT_PSL_AND_BE CHANGES NOTE2BE4USERS README UPGRADE_FROM_048 \
		doc/Bibliography.txt doc/CREDITS doc/README.1st
	dohtml INSTALL.html INSTALL_ES.html

	dodir ${MY_HOSTROOTDIR}/${PN}
	cp -R class cvs2cl.pl makecl.sh tables ${D}/${MY_HOSTROOTDIR}/${PN}
	cp -R public_html/* ${D}/${MY_HTDOCSDIR}

	dodir ${MY_HTDOCSDIR}/updir/dynamicPDFcache ${MY_HTDOCSDIR}/updir/images/en
	webapp_serverowned ${MY_HTDOCSDIR}/config.ini.php
	webapp_serverowned ${MY_HTDOCSDIR}/updir
	cd public_html/updir
	for file in `find`; do
		webapp_serverowned ${MY_HTDOCSDIR}/updir/${file}
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
