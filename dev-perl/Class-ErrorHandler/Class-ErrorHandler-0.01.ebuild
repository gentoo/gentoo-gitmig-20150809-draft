# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-ErrorHandler/Class-ErrorHandler-0.01.ebuild,v 1.10 2006/02/20 16:48:53 corsair Exp $

inherit perl-module

DESCRIPTION="Automated accessor generation"
HOMEPAGE="http://search.cpan.org/~btrott/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="alpha hppa ~ia64 ~ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build"
