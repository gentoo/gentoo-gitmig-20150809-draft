# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Return-Value/Return-Value-1.302.ebuild,v 1.4 2007/03/27 11:04:18 armin76 Exp $

inherit perl-module


DESCRIPTION="Polymorphic Return Values"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl"

SRC_TEST="do"
