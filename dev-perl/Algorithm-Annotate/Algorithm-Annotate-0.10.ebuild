# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Annotate/Algorithm-Annotate-0.10.ebuild,v 1.6 2005/02/05 14:30:52 absinthe Exp $

inherit perl-module

DESCRIPTION="Algorithm::Annotate - represent a series of changes in annotate form"
SRC_URI="http://www.cpan.org/modules/by-authors/id/C/CL/CLKAO/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~ppc sparc x86 ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/Algorithm-Diff-1.15"
