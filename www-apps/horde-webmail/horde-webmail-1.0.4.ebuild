# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-webmail/horde-webmail-1.0.4.ebuild,v 1.1 2008/01/12 05:10:41 vapier Exp $

HORDE_PN=${PN}
inherit horde

DESCRIPTION="browser based communication suite"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="crypt mysql postgres ldap oracle"

DEPEND=""
RDEPEND="!www-apps/horde
	crypt? ( app-crypt/gnupg )
	virtual/php
	>=www-apps/horde-pear-1.3
	dev-php/PEAR-Log
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-DB"

pkg_setup() {
	HORDE_PHP_FEATURES="
		imap ssl session xml nls iconv gd ftp
		$(use ldap && echo ldap) $(use oracle && echo oci8)
		$(use crypt && echo crypt) $(use mysql && echo mysql mysqli)
		$(use postgres && echo postgres)
	"
	horde_pkg_setup
}
