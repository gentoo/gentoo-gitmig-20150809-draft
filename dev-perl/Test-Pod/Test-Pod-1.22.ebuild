# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.22.ebuild,v 1.15 2008/11/18 15:38:22 tove Exp $

inherit perl-module

DESCRIPTION="check for POD errors in files"
HOMEPAGE="http://search.cpan.org/~petdance/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/perl-Pod-Simple
	>=virtual/perl-Test-Simple-0.62
	dev-lang/perl"
