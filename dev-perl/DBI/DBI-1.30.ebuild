# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/DBI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DBI/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/PlRPC-0.2"

mydoc="ToDo"
