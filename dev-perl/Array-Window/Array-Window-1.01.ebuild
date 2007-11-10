# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-1.01.ebuild,v 1.4 2007/11/10 11:56:31 drac Exp $

inherit perl-module

DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk"
IUSE=""
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl"
