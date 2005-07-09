# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.43.ebuild,v 1.12 2005/07/09 23:14:06 swegener Exp $

inherit perl-module

DESCRIPTION="perl5 module to create charts using the GD module"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MV/MVERB/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/GDTextUtil
	media-libs/gd"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
