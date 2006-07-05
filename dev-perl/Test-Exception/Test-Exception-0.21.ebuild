# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Exception/Test-Exception-0.21.ebuild,v 1.5 2006/07/05 10:25:47 ian Exp $

inherit perl-module

DESCRIPTION="test functions for exception based code"
HOMEPAGE="http://search.cpan.org/~adie/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADIE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="|| ( 	>=virtual/perl-Test-Simple-0.62
		( <virtual/perl-Test-Simple-0.62 dev-perl/Test-Builder-Tester ) )
	dev-perl/module-build
	dev-perl/Sub-Uplevel"
RDEPEND="${DEPEND}"