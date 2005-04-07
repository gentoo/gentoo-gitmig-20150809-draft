# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.20.ebuild,v 1.7 2005/04/07 20:49:09 hansmi Exp $

inherit perl-module

CATEGORY="dev-perl"

DESCRIPTION="check for POD errors in files"
HOMEPAGE="http://search.cpan.org/~petdance/${P}"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha ~ppc64"
IUSE=""

DEPEND="dev-perl/Pod-Simple
		dev-perl/Test-Builder-Tester"
