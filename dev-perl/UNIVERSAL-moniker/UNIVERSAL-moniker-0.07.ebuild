# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-moniker/UNIVERSAL-moniker-0.07.ebuild,v 1.1 2004/03/31 12:09:11 mcummings Exp $

inherit perl-module

DESCRIPTION="adds a moniker to every class or module"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/K/KA/KASEI/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86"
SRC_TEST="do"

#Funny...no longer a dep, but needed for tests
DEPEND="dev-perl/Lingua-EN-Inflect"
