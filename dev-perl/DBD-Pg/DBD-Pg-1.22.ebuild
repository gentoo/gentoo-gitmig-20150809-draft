# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-Pg/DBD-Pg-1.22.ebuild,v 1.3 2004/01/16 03:56:02 esammer Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD::Pg Module"
SRC_URI="http://cpan.pair.com/authors/id/D/DW/DWHEELER/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/authors/id/D/DW/DWHEELER/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Test-Simple
	dev-perl/DBI
	dev-db/postgresql"

# env variables for compilation:
export POSTGRES_INCLUDE=/usr/include/postgresql/
export POSTGRES_LIB=/usr/lib/postgresql/

mydoc="Changes README"
