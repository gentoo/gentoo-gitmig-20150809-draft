# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_CHAP/PEAR-Crypt_CHAP-1.0.2.ebuild,v 1.4 2010/11/05 04:33:46 jer Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Generating CHAP packets"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

pkg_postinst() {
	has_php
	if ! built_with_use --missing true =${PHP_PKG} crypt mhash ; then
		elog "${PN} can optionally use ${PHP_PKG} crypt and mhash features."
		elog "If you want those, recompile ${PHP_PKG} with these flags in USE."
	fi
}
