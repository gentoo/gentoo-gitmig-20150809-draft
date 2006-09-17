# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Auth/PEAR-Auth-1.3.2.ebuild,v 1.1 2006/09/17 13:52:44 chtekk Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides methods for creating an authentication system using PHP."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1
		dev-php/PEAR-File_Passwd
		dev-php/PEAR-Net_POP3
		dev-php/PEAR-MDB
		dev-php/PEAR-MDB2
		dev-php/PEAR-Crypt_CHAP
		dev-php/PEAR-File_SMBPasswd"

pkg_setup() {
	require_php_with_use crypt mhash
}
