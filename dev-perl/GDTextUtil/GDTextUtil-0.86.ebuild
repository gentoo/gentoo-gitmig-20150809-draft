# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.86.ebuild,v 1.18 2009/12/23 19:02:43 grobian Exp $

inherit perl-module

DESCRIPTION="Text utilities for use with GD"
SRC_URI="mirror://cpan/authors/id/M/MV/MVERB/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mverb/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

DEPEND="dev-perl/GD
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
