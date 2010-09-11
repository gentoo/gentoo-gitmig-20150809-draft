# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-groupware/horde-groupware-1.2.4.ebuild,v 1.2 2010/09/11 15:08:43 mabi Exp $

HORDE_PN="${PN}"

HORDE_APPLICATIONS="kronolith mnemo nag turba"

inherit horde

DESCRIPTION="Horde GroupWare"
HOMEPAGE="http://www.horde.org/"

KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="mysql postgres ldap oracle"

DEPEND=""
RDEPEND="!www-apps/horde
	dev-lang/php
	>=www-apps/horde-pear-1.3
	dev-php/PEAR-Log
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-DB"

pkg_setup() {
	HORDE_PHP_FEATURES="
		session xml nls crypt iconv gd ssl ftp
		$(use ldap && echo ldap) $(use oracle && echo oci8)
		$(use mysql && echo mysql mysqli) $(use postgres && echo postgres)
	"
	horde_pkg_setup
}

src_unpack() {
	horde_src_unpack
	cd "${S}"
	chmod 600 scripts/sql/create.*.sql #137510
}

pkg_postinst() {
	horde_pkg_postinst
	elog "Horde requires PHP to have:"
	elog "    ==> 'short_open_tag enabled = On'"
	elog "    ==> 'magic_quotes_runtime set = Off'"
	elog "    ==> 'file_uploads enabled = On'"
}
