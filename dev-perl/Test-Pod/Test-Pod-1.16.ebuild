# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.16.ebuild,v 1.3 2004/07/14 20:40:42 agriffis Exp $

inherit perl-module

CATEGORY="dev-perl"

DESCRIPTION="check for POD errors in files"
HOMEPAGE="http://search.cpan.org/~petdance/${P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="dev-perl/Pod-Simple
		dev-perl/Test-Builder-Tester"
