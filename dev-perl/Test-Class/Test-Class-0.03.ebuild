# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Class/Test-Class-0.03.ebuild,v 1.1 2004/03/29 11:23:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~adie/${P}/"
SRC_URI="http://www.cpan.org/authors/id/A/AD/ADIE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-perl/Attribute-Handlers
		dev-perl/Class-ISA
		>=dev-perl/Storable-2*
		dev-perl/Test-Simple
		dev-perl/Test-Builder-Tester
		dev-perl/Test-Exception
		dev-perl/Test-SimpleUnit
		dev-perl/Pod-Coverage"
