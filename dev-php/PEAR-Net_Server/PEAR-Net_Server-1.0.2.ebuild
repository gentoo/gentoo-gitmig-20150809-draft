# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Server/PEAR-Net_Server-1.0.2.ebuild,v 1.1 2007/08/20 22:20:05 jokey Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Generic server class for PHP."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use sockets
}

pkg_postinst() {
	has_php
	if ! built_with_use --missing true =${PHP_PKG} pcntl ; then
		elog "${PN} can optionally use ${PHP_PKG} pcntl features."
		elog "If you want those, recompile ${PHP_PKG} with this flag in USE."
	fi
}
