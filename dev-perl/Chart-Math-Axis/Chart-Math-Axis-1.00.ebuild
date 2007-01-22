# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-1.00.ebuild,v 1.4 2007/01/22 04:20:48 kloeri Exp $

inherit perl-module

DESCRIPTION="Implements an algorithm to find good values for chart axis"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.orga/~adamk/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Math-BigInt-1.70
	dev-perl/Clone
	virtual/perl-Test-Simple
	dev-perl/Params-Util
	dev-lang/perl"
