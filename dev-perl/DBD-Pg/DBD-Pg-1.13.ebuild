# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Gontran Zepeda  <gontran@gontran.net>

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD::Pg Module"
SRC_URI="http://www.cpan.org/authors/id/JBAKER/${P}.tar.gz"
DEPEND="${DEPEND} dev-perl/DBI dev-db/postgresql"
LICENSE="Artistic | GPL-2"
SLOT="0"

# env variables for compilation:
export POSTGRES_INCLUDE=/usr/include/postgresql/
export POSTGRES_LIB=/usr/lib/postgresql/

mydoc="Changes README"
