# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHPUnit2/PEAR-PHPUnit2-2.1.5.ebuild,v 1.1 2005/02/12 09:57:31 sebastian Exp $

inherit php-pear

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-php/php-5.0.2
	dev-php/PEAR-Benchmark
	dev-php/PEAR-Log"
