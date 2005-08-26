# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ISO/Date-ISO-1.30.ebuild,v 1.13 2005/08/26 03:12:50 agriffis Exp $

inherit perl-module

MY_P=Date-ISO-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Date::ICal subclass that handles ISO format dates"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Date-Leapyear
	perl-core/Test-Simple
	dev-perl/Date-ICal
	perl-core/Memoize"
