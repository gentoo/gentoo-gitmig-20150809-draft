# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI/Class-DBI-0.96.ebuild,v 1.17 2006/07/03 21:05:24 ian Exp $

inherit perl-module

DESCRIPTION="Simple Database Abstraction"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE=""

# Tests aren't possible since they require interaction with the DB's

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Class-Accessor
		dev-perl/Class-Trigger
		virtual/perl-File-Temp
		virtual/perl-Storable
		virtual/perl-Test-Simple
		virtual/perl-Scalar-List-Utils
		dev-perl/Ima-DBI
		dev-perl/UNIVERSAL-moniker"
RDEPEND="${DEPEND}"