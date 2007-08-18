# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNS/PEAR-Net_DNS-1.0.0.ebuild,v 1.1 2007/08/18 15:27:53 hoffie Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Resolver library used to communicate with a DNS server."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use mhash
}
