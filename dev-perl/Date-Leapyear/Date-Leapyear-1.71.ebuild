# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.71.ebuild,v 1.21 2012/03/19 19:42:15 armin76 Exp $

inherit perl-module

DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbow/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	virtual/perl-Test-Harness
	dev-lang/perl"
