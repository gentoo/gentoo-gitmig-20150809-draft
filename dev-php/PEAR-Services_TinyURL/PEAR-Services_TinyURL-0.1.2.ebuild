# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_TinyURL/PEAR-Services_TinyURL-0.1.2.ebuild,v 1.1 2008/03/17 12:49:49 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="An interface for creating TinyURLs with their API as well as looking up destinations of given TinyURLs."

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use curl
}
