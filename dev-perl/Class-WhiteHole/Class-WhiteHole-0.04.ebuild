# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-WhiteHole/Class-WhiteHole-0.04.ebuild,v 1.2 2004/05/06 17:44:16 ciaranm Exp $

inherit perl-module

DESCRIPTION="base class to treat unhandled method calls as errors"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
SRC_TEST="do"
