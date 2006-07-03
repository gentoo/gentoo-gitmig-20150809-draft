# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-DBI/Apache-DBI-0.99.01.ebuild,v 1.3 2006/07/03 20:09:13 ian Exp $

inherit perl-module

MY_PV=${PV/99.01/9901}
MY_P="$PN-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Apache::DBI module for perl"
SRC_URI="mirror://cpan/authors/id/P/PG/PGOLLUCCI/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pgollucci/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Digest-SHA1-2.01
	>=dev-perl/DBI-1.30"
RDEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"