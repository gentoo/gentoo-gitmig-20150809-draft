# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX-Base/XML-SAX-Base-1.04.ebuild,v 1.2 2004/06/25 01:13:40 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Base class SAX Drivers and Filters"
SRC_URI="http://search.cpan.org/CPAN/authors/id/K/KH/KHAMPTON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~khampton/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~mips"

DEPEND="${DEPEND}"

