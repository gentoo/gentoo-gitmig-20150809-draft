# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod-Coverage/Test-Pod-Coverage-1.06.ebuild,v 1.1 2004/09/22 14:25:06 mcummings Exp $

inherit perl-module

DESCRIPTION="Check for pod coverage in your distribution"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-perl/Test-Simple-0.47
		dev-perl/Pod-Coverage
		dev-perl/Test-Builder-Tester"
