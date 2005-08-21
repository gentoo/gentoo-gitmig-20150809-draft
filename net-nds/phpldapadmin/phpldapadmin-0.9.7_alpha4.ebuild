# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-0.9.7_alpha4.ebuild,v 1.1 2005/08/21 15:41:46 rl03 Exp $

inherit webapp

MY_P=${P/_alpha/-alpha}

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND="virtual/php"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv config.php.example config.php
}

src_install() {
	webapp_src_preinst

	dodoc INSTALL doc/*

	cp -r . ${D}${MY_HTDOCSDIR}
	cd ${D}${MY_HTDOCSDIR}
	rm -rf INSTALL LICENSE VERSION doc

	webapp_configfile ${MY_HTDOCSDIR}/config.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
