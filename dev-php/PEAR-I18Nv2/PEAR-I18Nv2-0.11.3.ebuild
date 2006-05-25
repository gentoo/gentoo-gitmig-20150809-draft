# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-I18Nv2/PEAR-I18Nv2-0.11.3.ebuild,v 1.2 2006/05/25 18:04:57 nixnut Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Internationalization"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcre iconv
}
