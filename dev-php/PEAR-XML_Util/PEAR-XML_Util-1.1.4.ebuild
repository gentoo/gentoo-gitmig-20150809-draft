# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Util/PEAR-XML_Util-1.1.4.ebuild,v 1.4 2007/09/25 01:14:44 pylon Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="XML utility class"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcre
}
