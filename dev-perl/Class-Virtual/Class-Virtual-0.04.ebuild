# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Virtual/Class-Virtual-0.04.ebuild,v 1.2 2005/01/21 20:09:54 mcummings Exp $

inherit perl-module

DESCRIPTION="Base class for virtual base classes."
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Class-ISA
		dev-perl/Carp-Assert"
