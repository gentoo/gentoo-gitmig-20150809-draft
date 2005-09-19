# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHPUnit2/PEAR-PHPUnit2-2.2.1.ebuild,v 1.5 2005/09/19 15:45:30 mr_bones_ Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Benchmark
	dev-php/PEAR-Log"

need_php5
