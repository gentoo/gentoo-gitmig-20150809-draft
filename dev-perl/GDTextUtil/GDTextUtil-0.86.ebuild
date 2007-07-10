# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.86.ebuild,v 1.17 2007/07/10 23:33:33 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Text utilities for use with GD"
SRC_URI="mirror://cpan/authors/id/M/MV/MVERB/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mverb/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-perl/GD
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
