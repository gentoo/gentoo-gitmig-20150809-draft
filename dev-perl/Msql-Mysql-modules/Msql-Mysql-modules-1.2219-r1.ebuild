# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Msql-Mysql-modules/Msql-Mysql-modules-1.2219-r1.ebuild,v 1.3 2002/12/15 10:44:15 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl MySQL Module"
SRC_URI="http://www.cpan.org/modules/by-module/Msql/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Msql/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

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
