# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod-Coverage/Test-Pod-Coverage-1.08.ebuild,v 1.12 2006/10/20 20:09:18 kloeri Exp $

inherit perl-module

DESCRIPTION="Check for pod coverage in your distribution"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc ~x86"

DEPEND=">=virtual/perl-Test-Simple-0.62
	dev-perl/Pod-Coverage
	dev-lang/perl"
RDEPEND="${DEPEND}"


