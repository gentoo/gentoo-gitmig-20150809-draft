# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Trigger/Class-Trigger-0.13.ebuild,v 1.3 2009/05/02 13:42:40 gentoofan23 Exp $

inherit perl-module

DESCRIPTION="Mixin to add / call inheritable triggers"
HOMEPAGE="http://search.cpan.org/~miyagawa/"
SRC_URI="mirror://cpan/authors/id/M/MI/MIYAGAWA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
		dev-perl/IO-stringy
		dev-perl/Class-Data-Inheritable
	dev-lang/perl"
