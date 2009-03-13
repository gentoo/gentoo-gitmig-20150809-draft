# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Random/Math-Random-0.71.ebuild,v 1.1 2009/03/13 00:04:35 weaver Exp $

inherit perl-module

DESCRIPTION="Random Number Generators"
HOMEPAGE="http://search.cpan.org/~grommel/Math-Random-0.71/Random.pm"
SRC_URI="mirror://cpan/authors/id/G/GR/GROMMEL/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl"
