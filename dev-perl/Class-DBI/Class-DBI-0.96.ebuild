# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI/Class-DBI-0.96.ebuild,v 1.11 2005/05/25 15:00:39 mcummings Exp $

inherit perl-module

DESCRIPTION="Simple Database Abstraction"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""

# Tests aren't possible since they require interaction with the DB's

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Class-Accessor
		dev-perl/Class-Trigger
		perl-core/File-Temp
		perl-core/Storable
		perl-core/Test-Simple
		dev-perl/Ima-DBI
		dev-perl/Scalar-List-Utils
		dev-perl/UNIVERSAL-moniker"
