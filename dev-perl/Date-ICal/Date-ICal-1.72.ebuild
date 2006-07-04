# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ICal/Date-ICal-1.72.ebuild,v 1.22 2006/07/04 07:39:14 ian Exp $

inherit perl-module

MY_P=Date-ICal-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="ICal format date base module for Perl"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Date-Leapyear
	virtual/perl-Test-Harness
	virtual/perl-Test-Simple
	virtual/perl-Time-Local
	virtual/perl-Time-HiRes
	virtual/perl-Storable"
RDEPEND="${DEPEND}"