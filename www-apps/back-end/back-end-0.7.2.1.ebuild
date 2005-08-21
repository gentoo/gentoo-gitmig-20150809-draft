# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/back-end/back-end-0.7.2.1.ebuild,v 1.1 2005/08/21 16:48:14 rl03 Exp $

inherit webapp

S=${WORKDIR}/${PN}${PV}

IUSE="ldap"

DESCRIPTION="Back-End is a multilingual Web publishing/content management system"
HOMEPAGE="http://back-end.org/"
SRC_URI="mirror://sourceforge//${PN}/${PN}${PV}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND="
	virtual/httpd-php
	>=dev-db/mysql-3.23
	ldap? ( net-nds/openldap )
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f Makefile
	cp public_html/config-dist.ini.php public_html/config.ini.php
}

src_install() {
	webapp_src_preinst
	local file
	local docs="ABOUT_PSL_AND_BE CHANGES NOTE2BE4USERS README UPGRADE_FROM_048 doc/Bibliography.txt doc/CREDITS doc/README.1st doc/changeHistory.txt"

	dodoc ${docs}
	dohtml INSTALL.html INSTALL_ES.html

	dodir ${MY_HOSTROOTDIR}/${PF}
	cp -R class tables ${D}/${MY_HOSTROOTDIR}/${PF}
	cp -R public_html/* ${D}/${MY_HTDOCSDIR}

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
