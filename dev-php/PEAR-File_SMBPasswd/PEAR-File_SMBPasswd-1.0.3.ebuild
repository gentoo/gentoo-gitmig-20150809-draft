# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_SMBPasswd/PEAR-File_SMBPasswd-1.0.3.ebuild,v 1.1 2009/08/22 18:51:00 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Class for managing SAMBA style password files."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Crypt_CHAP-1.0.0"

pkg_setup() {
	require_php_with_use mhash
}
