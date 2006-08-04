# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-0.4.ebuild,v 1.14 2006/08/04 22:25:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Array/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	dev-perl/Class-Inspector
	dev-lang/perl"
RDEPEND="${DEPEND}"
