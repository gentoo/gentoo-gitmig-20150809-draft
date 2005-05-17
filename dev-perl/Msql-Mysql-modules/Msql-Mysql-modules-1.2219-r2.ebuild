# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Msql-Mysql-modules/Msql-Mysql-modules-1.2219-r2.ebuild,v 1.1 2005/05/17 09:15:27 robbat2 Exp $

inherit perl-module eutils

DESCRIPTION="The Perl MySQL Module"
SRC_URI="mirror://cpan/authors/id/J/JW/JWIED/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Msql/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

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

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${PN}-mysql-4.1.patch
}

