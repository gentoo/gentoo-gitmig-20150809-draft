# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_oci8/PEAR-MDB2_Driver_oci8-1.5.0_alpha2.ebuild,v 1.6 2008/03/28 23:57:41 maekke Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Database Abstraction Layer, oci8 driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 -ppc -ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_alpha2"
RDEPEND="${DEPEND}"

pkg_setup() {
	require_php_with_any_use oci8 oci8-instant-client
}
