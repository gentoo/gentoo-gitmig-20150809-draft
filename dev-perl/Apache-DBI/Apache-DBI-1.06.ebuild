# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-DBI/Apache-DBI-1.06.ebuild,v 1.10 2012/03/19 19:19:03 armin76 Exp $

inherit perl-module

DESCRIPTION="Apache::DBI module for perl"
SRC_URI="mirror://cpan/authors/id/P/PG/PGOLLUCCI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pgollucci/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Digest-SHA1-2.01
	>=dev-perl/DBI-1.30
	dev-lang/perl"

export OPTIMIZE="$CFLAGS"
