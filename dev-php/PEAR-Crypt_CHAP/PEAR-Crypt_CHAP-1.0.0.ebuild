# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Crypt_CHAP/PEAR-Crypt_CHAP-1.0.0.ebuild,v 1.6 2006/09/17 03:39:26 vapier Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Generating CHAP packets."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use crypt mhash
}
