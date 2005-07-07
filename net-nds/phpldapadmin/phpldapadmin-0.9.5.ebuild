# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-0.9.5.ebuild,v 1.3 2005/07/07 15:11:15 rl03 Exp $

inherit webapp

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"
IUSE=""

DEPEND="virtual/php"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv config.php.example config.php
}

src_install() {
	webapp_src_preinst

	local docs="INSTALL LICENSE doc/CREDITS doc/ChangeLog doc/INSTALL-de.txt doc/INSTALL-es.txt doc/INSTALL-fr.txt doc/ROADMAP"

	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	einfo "Installing main files"
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/config.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
