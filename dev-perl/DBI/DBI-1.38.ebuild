# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI/DBI-1.38.ebuild,v 1.9 2004/04/02 15:28:12 randy Exp $
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/DBI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DBI/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="ia64 x86 ~amd64 ~ppc ~alpha sparc hppa mips s390"

DEPEND="${DEPEND}
	>=dev-perl/PlRPC-0.2"

mydoc="ToDo"
