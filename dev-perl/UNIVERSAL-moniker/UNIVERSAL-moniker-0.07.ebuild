# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-moniker/UNIVERSAL-moniker-0.07.ebuild,v 1.3 2004/06/08 12:16:14 dholm Exp $

inherit perl-module

DESCRIPTION="adds a moniker to every class or module"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/K/KA/KASEI/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
SRC_TEST="do"

#Funny...no longer a dep, but needed for tests
DEPEND="dev-perl/Lingua-EN-Inflect"
