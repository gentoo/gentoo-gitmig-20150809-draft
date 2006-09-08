# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-2.3.6.ebuild,v 1.1 2006/09/08 08:26:30 sebastian Exp $

inherit php-pear-lib-r1

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
DEPEND="!dev-php4/phpunit"
RDEPEND=">=dev-php/PEAR-Benchmark-1.2.2-r1
	>=dev-php/PEAR-Log-1.8.7-r1"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
S="${WORKDIR}/PHPUnit-${PV}"

pkg_setup() {
	require_php_with_use pcre spl xml

	if has_version '>=dev-lang/php-5.1.2' ; then
		require_php_with_use reflection
	fi
}

need_php_by_category
