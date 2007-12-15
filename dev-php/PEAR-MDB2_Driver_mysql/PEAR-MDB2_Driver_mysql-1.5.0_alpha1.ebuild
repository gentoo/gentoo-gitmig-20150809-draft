# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_mysql/PEAR-MDB2_Driver_mysql-1.5.0_alpha1.ebuild,v 1.8 2007/12/15 11:52:12 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Database Abstraction Layer, mysql driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_alpha1"
RDEPEND="${DEPEND}"

pkg_setup() {
	has_php
	require_php_with_use mysql
}
