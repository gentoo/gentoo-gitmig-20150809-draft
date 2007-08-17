# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Benchmark/PEAR-Benchmark-1.2.7.ebuild,v 1.1 2007/08/17 13:48:37 hoffie Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Framework to benchmark PHP scripts or function calls."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_postinst() {
	has_php
	if ! built_with_use --missing true =${PHP_PKG} bcmath ; then
		elog "${PN} can optionally use ${PHP_PKG} bcmath features."
		elog "If you want those, recompile ${PHP_PKG} with these flags in USE."
	fi
}
