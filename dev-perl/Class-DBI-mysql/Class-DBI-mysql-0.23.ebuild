# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-mysql/Class-DBI-mysql-0.23.ebuild,v 1.11 2006/07/03 21:09:57 ian Exp $

inherit perl-module

DESCRIPTION="Extensions to Class::DBI for MySQL"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""

#Can't put tests here because they require interaction with the DB

DEPEND="dev-perl/Class-DBI
		virtual/perl-Test-Simple
		dev-perl/DBD-mysql"
RDEPEND="${DEPEND}"