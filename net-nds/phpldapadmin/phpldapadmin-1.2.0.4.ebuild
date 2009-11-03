# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-1.2.0.4.ebuild,v 1.2 2009/11/03 17:37:09 armin76 Exp $

inherit webapp depend.php

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use hash ldap pcre session xml nls
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv config/config.php.example config/config.php
}

src_install() {
	webapp_src_preinst

	dodoc INSTALL

	insinto "${MY_HTDOCSDIR}"
	doins -r *

	webapp_configfile "${MY_HTDOCSDIR}"/config/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall2-en.txt

	webapp_src_install
}
