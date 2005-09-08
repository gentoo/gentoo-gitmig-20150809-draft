# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHPUnit2/PEAR-PHPUnit2-2.2.1.ebuild,v 1.3 2005/09/08 08:30:46 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-lang/php-5.0.2
	dev-php/PEAR-Benchmark
	dev-php/PEAR-Log"
