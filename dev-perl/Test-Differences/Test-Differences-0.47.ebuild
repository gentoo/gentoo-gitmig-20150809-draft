# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Differences/Test-Differences-0.47.ebuild,v 1.8 2006/07/05 10:24:27 ian Exp $

inherit perl-module

DESCRIPTION="Test strings and data structures and show differences if not ok"
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 sparc x86"
IUSE=""

DEPEND="dev-perl/Text-Diff"
RDEPEND="${DEPEND}"