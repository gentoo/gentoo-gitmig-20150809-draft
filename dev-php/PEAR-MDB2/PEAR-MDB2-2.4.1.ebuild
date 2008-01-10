# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2/PEAR-MDB2-2.4.1.ebuild,v 1.10 2008/01/10 10:06:19 vapier Exp $

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="mssql mysql mysqli oci8 oci8-instant-client postgres sqlite"

PDEPEND="mssql? ( dev-php/PEAR-MDB2_Driver_mssql )
		mysql? ( dev-php/PEAR-MDB2_Driver_mysql )
		mysqli? ( dev-php/PEAR-MDB2_Driver_mysqli )
		oci8? ( dev-php/PEAR-MDB2_Driver_oci8 )
		oci8-instant-client? ( dev-php/PEAR-MDB2_Driver_oci8 )
		postgres? ( dev-php/PEAR-MDB2_Driver_pgsql )
		sqlite? ( dev-php/PEAR-MDB2_Driver_sqlite )"
