# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_ibase/PEAR-MDB2_Driver_ibase-1.5.0_beta3.ebuild,v 1.2 2011/11/03 11:42:46 chainsaw Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer, ibase driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta3
		|| ( dev-lang/php[firebird] dev-lang/php[interbase] )"
RDEPEND="${DEPEND}"
