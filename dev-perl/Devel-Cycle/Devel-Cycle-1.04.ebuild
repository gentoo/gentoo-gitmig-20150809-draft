# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Cycle/Devel-Cycle-1.04.ebuild,v 1.6 2006/06/08 20:17:17 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Find memory cycles in objects"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"
