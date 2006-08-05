# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Cycle/Devel-Cycle-1.02.ebuild,v 1.3 2006/08/05 02:50:37 mcummings Exp $

inherit perl-module

DESCRIPTION="Find memory cycles in objects"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
