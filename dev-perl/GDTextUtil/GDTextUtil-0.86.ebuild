# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.86.ebuild,v 1.12 2005/07/09 23:08:25 swegener Exp $

inherit perl-module

DESCRIPTION="Text utilities for use with GD"
SRC_URI="mirror://cpan/authors/id/M/MV/MVERB/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/GD"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
