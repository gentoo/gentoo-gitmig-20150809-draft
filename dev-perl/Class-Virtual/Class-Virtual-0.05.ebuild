# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Virtual/Class-Virtual-0.05.ebuild,v 1.2 2005/07/18 11:51:25 dholm Exp $

inherit perl-module

DESCRIPTION="Base class for virtual base classes."
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Carp-Assert"
