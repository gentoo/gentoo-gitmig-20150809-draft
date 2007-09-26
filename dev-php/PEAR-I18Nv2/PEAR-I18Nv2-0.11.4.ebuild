# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-I18Nv2/PEAR-I18Nv2-0.11.4.ebuild,v 1.5 2007/09/26 17:58:18 ranger Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Internationalization - basic support to localize your application."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcre iconv
}
