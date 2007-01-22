# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI/Class-DBI-3.0.16.ebuild,v 1.4 2007/01/22 04:25:24 kloeri Exp $

inherit perl-module

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Simple Database Abstraction"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

# Tests aren't possible since they require interaction with the DB's

DEPEND=">=dev-perl/Class-Data-Inheritable-0.02
		>=dev-perl/Class-Accessor-0.18
		>=dev-perl/Class-Trigger-0.07
		virtual/perl-File-Temp
		virtual/perl-Storable
		virtual/perl-Test-Simple
		virtual/perl-Scalar-List-Utils
		dev-perl/Clone
		>=dev-perl/Ima-DBI-0.33
		dev-perl/version
		>=dev-perl/UNIVERSAL-moniker-0.06
	dev-lang/perl"
