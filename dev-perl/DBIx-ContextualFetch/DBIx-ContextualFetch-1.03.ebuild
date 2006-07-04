# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-ContextualFetch/DBIx-ContextualFetch-1.03.ebuild,v 1.6 2006/07/04 07:22:58 ian Exp $

inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

# DBD-SQLite is for testing
DEPEND=">=dev-perl/DBI-1.37
		dev-perl/DBD-SQLite
		virtual/perl-Test-Simple"
RDEPEND="${DEPEND}"