# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNS/PEAR-Net_DNS-1.0.0.ebuild,v 1.9 2007/12/06 00:39:10 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Resolver library used to communicate with a DNS server."
LICENSE="PHP-3.01 || ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use mhash
}
