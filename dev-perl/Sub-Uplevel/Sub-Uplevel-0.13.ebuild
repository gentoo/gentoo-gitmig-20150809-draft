# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Uplevel/Sub-Uplevel-0.13.ebuild,v 1.6 2006/10/20 23:00:50 agriffis Exp $

inherit perl-module

DESCRIPTION="apparently run a function in a higher stack frame"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DA/DAGOLDEN/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~mips ~ppc ~ppc64 sparc ~x86"
IUSE=""


DEPEND="dev-perl/module-build
		dev-lang/perl"
RDEPEND="dev-lang/perl"
