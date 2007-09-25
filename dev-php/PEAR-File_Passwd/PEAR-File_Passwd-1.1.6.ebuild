# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Passwd/PEAR-File_Passwd-1.1.6.ebuild,v 1.8 2007/09/25 00:01:24 pylon Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Manipulate many kinds of password files."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""
RDEPEND="dev-php/PEAR-Crypt_CHAP"

pkg_setup() {
	require_php_with_use pcre
}
