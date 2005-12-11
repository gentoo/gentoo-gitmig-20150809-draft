# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-0.9.7.ebuild,v 1.2 2005/12/11 05:11:29 tsunam Exp $

inherit webapp versionator

MY_P=${PN}-$(replace_version_separator 3 '-')

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND="virtual/httpd-php"

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

	webapp_configfile ${MY_HTDOCSDIR}/config.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
