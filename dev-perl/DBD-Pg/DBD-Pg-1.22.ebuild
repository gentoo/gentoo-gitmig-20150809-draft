# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-Pg/DBD-Pg-1.22.ebuild,v 1.13 2005/05/25 15:03:35 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl DBD::Pg Module"
HOMEPAGE="http://search.cpan.org/~dwheeler/${P}"
SRC_URI="mirror://cpan/authors/id/D/DW/DWHEELER/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc s390 sparc x86"
IUSE=""

DEPEND="perl-core/Test-Simple
	dev-perl/DBI
	dev-db/postgresql"

# env variables for compilation:
export POSTGRES_INCLUDE=/usr/include/postgresql/
export POSTGRES_LIB=/usr/lib/postgresql/

mydoc="Changes README"
