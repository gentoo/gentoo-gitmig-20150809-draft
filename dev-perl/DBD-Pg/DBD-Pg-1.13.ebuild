# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-Pg/DBD-Pg-1.13.ebuild,v 1.10 2002/12/15 10:44:13 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD::Pg Module"
SRC_URI="http://www.cpan.org/authors/id/JBAKER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/JBAKER/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/DBI
	dev-db/postgresql"

# env variables for compilation:
export POSTGRES_INCLUDE=/usr/include/postgresql/
export POSTGRES_LIB=/usr/lib/postgresql/

mydoc="Changes README"
