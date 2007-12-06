# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/symfony/symfony-1.0.9.ebuild,v 1.1 2007/12/06 01:24:28 jokey Exp $

inherit php-pear-lib-r1 depend.php

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Open-source PHP5 professional web framework."
HOMEPAGE="http://www.symfony-project.com/"
SRC_URI="http://pear.symfony-project.com/get/${P}.tgz"
LICENSE="MIT LGPL-2.1 BSD BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category

pkg_setup() {
	# Symfony needs some features in PHP5 in order to work
	require_php_with_use cli ctype reflection spl simplexml xml pcre session
}
