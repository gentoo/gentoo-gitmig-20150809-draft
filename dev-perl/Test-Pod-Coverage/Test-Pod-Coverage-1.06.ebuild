# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod-Coverage/Test-Pod-Coverage-1.06.ebuild,v 1.10 2005/08/26 00:22:59 agriffis Exp $

inherit perl-module

DESCRIPTION="Check for pod coverage in your distribution"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND=">=perl-core/Test-Simple-0.47
		dev-perl/Pod-Coverage
		dev-perl/Test-Builder-Tester"
