# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHPUnit2/PEAR-PHPUnit2-2.3.2.ebuild,v 1.2 2005/10/24 13:46:22 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Benchmark-1.2.2-r1
	>=dev-php/PEAR-Log-1.8.7-r1"

need_php5
