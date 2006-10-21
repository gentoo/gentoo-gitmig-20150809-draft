# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-SHA/Digest-SHA-5.32.ebuild,v 1.5 2006/10/21 16:35:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"
HOMEPAGE="http://search.cpan.org/~mshelor/${P}"
SRC_URI="mirror://cpan/authors/id/M/MS/MSHELOR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
