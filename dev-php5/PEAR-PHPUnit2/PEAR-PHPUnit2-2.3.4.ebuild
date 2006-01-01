# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/PEAR-PHPUnit2/PEAR-PHPUnit2-2.3.4.ebuild,v 1.1 2006/01/01 17:03:51 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Benchmark-1.2.2-r1
	>=dev-php/PEAR-Log-1.8.7-r1"

need_php5
