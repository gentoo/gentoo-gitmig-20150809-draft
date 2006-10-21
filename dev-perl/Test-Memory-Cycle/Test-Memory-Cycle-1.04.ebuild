# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Memory-Cycle/Test-Memory-Cycle-1.04.ebuild,v 1.4 2006/10/21 14:39:11 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Check for memory leaks and circular memory references"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Devel-Cycle-1.04
	>=virtual/perl-Test-Simple-0.62
	dev-lang/perl"
