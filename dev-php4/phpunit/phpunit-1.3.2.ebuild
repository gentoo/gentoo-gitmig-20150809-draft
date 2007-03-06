# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/phpunit/phpunit-1.3.2.ebuild,v 1.2 2007/03/06 22:07:44 chtekk Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~sparc ~x86"

DESCRIPTION="Unit Testing framework for PHP 4."
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="!dev-php5/phpunit"
RDEPEND="${DEPEND}"

S="${WORKDIR}/PHPUnit-${PV}"
