# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_oci8/PEAR-MDB2_Driver_oci8-1.5.0_beta3.ebuild,v 1.2 2011/11/03 11:41:09 chainsaw Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer, oci8 driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta3
		|| ( dev-lang/php[oci8] dev-lang/php[oci8-instant-client] )"
RDEPEND="${DEPEND}"
