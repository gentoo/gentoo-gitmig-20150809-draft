# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Cycle/Devel-Cycle-1.02.ebuild,v 1.1 2004/12/05 13:34:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Find memory cycles in objects"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
