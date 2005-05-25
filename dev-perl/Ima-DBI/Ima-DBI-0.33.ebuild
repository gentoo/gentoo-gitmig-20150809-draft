# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ima-DBI/Ima-DBI-0.33.ebuild,v 1.9 2005/05/25 15:09:40 mcummings Exp $

inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/DBI
		dev-perl/Class-WhiteHole
		dev-perl/DBIx-ContextualFetch
		perl-core/Test-Simple"
