# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-0.10.ebuild,v 1.9 2006/08/20 01:20:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Utility funcions to aid in parameter checking"
HOMEPAGE="http://search.cpan.org/search?module=Param-Util"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Scalar-List-Utils-1.11
	dev-lang/perl"
