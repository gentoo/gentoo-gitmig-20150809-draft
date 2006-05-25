# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_CHAP/PEAR-Crypt_CHAP-1.0.0.ebuild,v 1.3 2006/05/25 18:16:34 nixnut Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Generating CHAP packets."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use crypt mhash
}
