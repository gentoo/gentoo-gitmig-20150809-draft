# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-0.20.ebuild,v 1.3 2006/10/21 01:11:06 mcummings Exp $

inherit perl-module

DESCRIPTION="Utility functions to aid in parameter checking"
HOMEPAGE="http://search.cpan.org/search?module=Param-Util"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-Scalar-List-Utils-1.14
	dev-lang/perl"
