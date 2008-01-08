# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-1.1.0.3.ebuild,v 1.1 2008/01/08 19:08:17 rl03 Exp $

inherit webapp depend.php

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

need_php5

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use ldap pcre session xml nls
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	mv config/config.php.example config/config.php
}

src_install() {
	webapp_src_preinst

	dodoc doc/* doc/certs/*

	cp -r . "${D}${MY_HTDOCSDIR}"
	cd "${D}${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}"/config/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall2-en.txt

	webapp_src_install
}
