# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_HMAC2/PEAR-Crypt_HMAC2-1.0.0.ebuild,v 1.2 2012/01/18 19:37:42 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Implementation of Hashed Message Authentication Code for PHP5"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_postinst() {
	if ! has_version "dev-lang/php[hash]" ; then
		elog "${PN} can use the hash extension when enabled to extend the range"
		elog "of cryptographic hash functions beyond the natively implemented MD5 and SHA1."
		elog "Recompile dev-lang/php with USE=\"hash\" if you want these features."
	fi
}
