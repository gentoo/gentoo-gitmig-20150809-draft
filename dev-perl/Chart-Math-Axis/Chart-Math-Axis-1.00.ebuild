# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-1.00.ebuild,v 1.7 2011/12/04 17:56:16 armin76 Exp $

inherit perl-module

DESCRIPTION="Implements an algorithm to find good values for chart axis"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.orga/~adamk/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 hppa ~mips ~ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Math-BigInt-1.70
	dev-perl/Clone
	virtual/perl-Test-Simple
	dev-perl/Params-Util
	dev-lang/perl"
