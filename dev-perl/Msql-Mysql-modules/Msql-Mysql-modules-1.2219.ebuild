# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Msql-Mysql-modules/Msql-Mysql-modules-1.2219.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl MySQL Module"
SRC_URI="http://www.cpan.org/modules/by-module/Msql/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Msql/${P}.readme"


SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/Data-ShowTable-3.3
	>=dev-db/mysql-3.23.30
	>=dev-perl/DBI-1.14"

myconf="--mysql-install \
	--nomsql-install \
	--nomsql1-install \
	--mysql-incdir=/usr/include/mysql \
	--mysql-libdir=/usr/lib \
	--noprompt"

mydoc="ToDo"
