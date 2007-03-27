# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Date/Email-Date-1.101.ebuild,v 1.5 2007/03/27 22:18:32 mabi Exp $

inherit perl-module

DESCRIPTION="Find and Format Date Headers"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Email-Abstract-2.13.1
	dev-perl/Time-Piece
	dev-perl/Email-Simple
	virtual/perl-Time-Local
	>=dev-perl/TimeDate-1.16
	dev-lang/perl"

SRC_TEST="do"
