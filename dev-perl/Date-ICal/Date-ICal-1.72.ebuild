# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ICal/Date-ICal-1.72.ebuild,v 1.19 2005/08/26 02:16:35 agriffis Exp $

inherit perl-module

MY_P=Date-ICal-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="ICal format date base module for Perl"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Date-Leapyear
	perl-core/Test-Harness
	perl-core/Test-Simple
	perl-core/Time-Local
	perl-core/Time-HiRes
	perl-core/Storable"
