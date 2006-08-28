# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-ISA/Class-ISA-0.33.ebuild,v 1.2 2006/08/28 19:20:14 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Report the search path thru an ISA tree"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~sburke"

LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TET="do"
SLOT="0"
DEPEND="dev-lang/perl"
