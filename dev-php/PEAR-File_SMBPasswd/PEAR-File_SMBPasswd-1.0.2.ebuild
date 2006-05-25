# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_SMBPasswd/PEAR-File_SMBPasswd-1.0.2.ebuild,v 1.2 2006/05/25 18:56:10 nixnut Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Class for managing SAMBA style password files."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Crypt_CHAP"

pkg_setup() {
	require_php_with_use mhash
}
