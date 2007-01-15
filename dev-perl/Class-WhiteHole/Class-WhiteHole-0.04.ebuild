# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-WhiteHole/Class-WhiteHole-0.04.ebuild,v 1.16 2007/01/15 15:02:14 mcummings Exp $

inherit perl-module

DESCRIPTION="base class to treat unhandled method calls as errors"
HOMEPAGE="http://search.cpan.org/~mschwern/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"
DEPEND="dev-lang/perl"
