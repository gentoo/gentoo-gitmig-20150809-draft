# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ima-DBI/Ima-DBI-0.33.ebuild,v 1.7 2005/01/30 00:20:56 luckyduck Exp $

inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/DBI
		dev-perl/Class-WhiteHole
		dev-perl/DBIx-ContextualFetch
		dev-perl/Test-Simple"
