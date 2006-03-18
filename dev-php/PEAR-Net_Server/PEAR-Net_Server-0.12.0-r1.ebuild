# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Server/PEAR-Net_Server-0.12.0-r1.ebuild,v 1.15 2006/03/18 13:50:52 jer Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Generic server class for PHP."

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use pcntl sockets
}
