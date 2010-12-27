# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2/PEAR-MDB2-2.5.0_beta3.ebuild,v 1.2 2010/12/27 22:02:08 olemarkus Exp $

EAPI="2"
inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="firebird mssql mysql mysqli oci8 oci8-instant-client postgres sqlite"

RDEPEND=">=dev-php/pear-1.9.1"
DEPEND="${RDEPEND}"

PDEPEND="firebird? ( >=dev-php/PEAR-MDB2_Driver_ibase-1.5.0_beta3 )
	mssql? ( >=dev-php/PEAR-MDB2_Driver_mssql-1.3.0_beta3 )
	mysql? ( >=dev-php/PEAR-MDB2_Driver_mysql-1.5.0_beta3 )
	mysqli? ( >=dev-php/PEAR-MDB2_Driver_mysqli-1.5.0_beta3 )
	oci8? ( >=dev-php/PEAR-MDB2_Driver_oci8-1.5.0_beta3 )
	oci8-instant-client? ( >=dev-php/PEAR-MDB2_Driver_oci8-1.5.0_beta3 )
	postgres? ( >=dev-php/PEAR-MDB2_Driver_pgsql-1.5.0_beta3 )
	sqlite? ( >=dev-php/PEAR-MDB2_Driver_sqlite-1.5.0_beta3 )"
