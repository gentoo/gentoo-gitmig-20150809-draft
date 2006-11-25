# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2/PEAR-MDB2-2.1.0.ebuild,v 1.3 2006/11/25 19:45:46 kloeri Exp $

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="mysql mysqli oci8 oci8-instant-client postgres sqlite"

PDEPEND="mysql? ( dev-php/PEAR-MDB2_Driver_mysql )
		mysqli? ( dev-php/PEAR-MDB2_Driver_mysqli )
		oci8? ( dev-php/PEAR-MDB2_Driver_oci8 )
		oci8-instant-client? ( dev-php/PEAR-MDB2_Driver_oci8 )
		postgres? ( dev-php/PEAR-MDB2_Driver_pgsql )
		sqlite? ( dev-php/PEAR-MDB2_Driver_sqlite )"
