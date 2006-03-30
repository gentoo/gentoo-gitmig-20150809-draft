# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Class/Test-Class-0.11.ebuild,v 1.10 2006/03/30 23:22:55 agriffis Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~adie/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADIE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""

DEPEND=">=virtual/perl-Storable-2
	dev-perl/module-build
	|| ( 	>=virtual/perl-Test-Simple-0.62
		( <virtual/perl-Test-Simple-0.62 dev-perl/Test-Builder-Tester ) )
	dev-perl/Test-Differences
	dev-perl/Test-Exception
	dev-perl/Test-SimpleUnit
	dev-perl/Pod-Coverage"
