# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Date/Email-Date-1.102.ebuild,v 1.11 2012/03/24 19:59:12 armin76 Exp $

inherit perl-module

DESCRIPTION="Find and Format Date Headers"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc ppc64 x86"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Email-Abstract-2.13.1
	virtual/perl-Time-Piece
	dev-perl/Email-Simple
	virtual/perl-Time-Local
	>=dev-perl/TimeDate-1.16
	dev-lang/perl"

SRC_TEST="do"
