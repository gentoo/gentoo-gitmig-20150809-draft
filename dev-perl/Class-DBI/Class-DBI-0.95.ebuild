# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI/Class-DBI-0.95.ebuild,v 1.6 2005/01/13 03:02:06 gustavoz Exp $

inherit perl-module

DESCRIPTION="Simple Database Abstraction"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

# Tests aren't possible since they require interaction with the DB's

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Class-Accessor
		dev-perl/Class-Trigger
		dev-perl/File-Temp
		dev-perl/Storable
		dev-perl/Test-Simple
		dev-perl/Ima-DBI
		dev-perl/Scalar-List-Utils
		dev-perl/UNIVERSAL-moniker"
