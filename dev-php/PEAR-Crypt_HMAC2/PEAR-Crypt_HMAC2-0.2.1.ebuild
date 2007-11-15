# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_HMAC2/PEAR-Crypt_HMAC2-0.2.1.ebuild,v 1.1 2007/11/15 18:03:56 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Implementation of Hashed Message Authentication Code for PHP5"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need_php5

pkg_postinst() {
	has_php
	local flags="hash mhash"
	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} ; then
		elog "${PN} can use the hash or mhash extensions when enabled to extend the range"
		elog "of cryptographic hash functions beyond the natively implemented MD5 and SHA1."
		elog "Recompile ${PHP_PKG} with ${flags} USE flags enabled if you want these features."
	fi
}
