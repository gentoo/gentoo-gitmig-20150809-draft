# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ima-DBI/Ima-DBI-0.35.ebuild,v 1.7 2011/04/24 15:32:30 grobian Exp $

inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"
HOMEPAGE="http://search.cpan.org/~perrin/"
SRC_URI="mirror://cpan/authors/id/P/PE/PERRIN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86 ~x86-solaris"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/DBI
	dev-perl/Class-WhiteHole
		dev-perl/DBIx-ContextualFetch
		virtual/perl-Test-Simple
		>=dev-perl/Class-Data-Inheritable-0.02
	dev-lang/perl"
