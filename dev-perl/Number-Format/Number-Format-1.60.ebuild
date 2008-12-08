# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Number-Format-1.60.ebuild,v 1.1 2008/12/08 01:56:55 robbat2 Exp $

inherit perl-module

DESCRIPTION="Package for formatting numbers for display"
SRC_URI="mirror://cpan/authors/id/W/WR/WRW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/W/WR/WRW/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
