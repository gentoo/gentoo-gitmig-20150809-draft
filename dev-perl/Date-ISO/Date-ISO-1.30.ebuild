# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ISO/Date-ISO-1.30.ebuild,v 1.12 2005/05/25 15:05:42 mcummings Exp $

inherit perl-module

MY_P=Date-ISO-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Date::ICal subclass that handles ISO format dates"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Date-Leapyear
	perl-core/Test-Simple
	dev-perl/Date-ICal
	perl-core/Memoize"
