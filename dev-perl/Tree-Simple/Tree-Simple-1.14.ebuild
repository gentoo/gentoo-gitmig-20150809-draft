# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-Simple/Tree-Simple-1.14.ebuild,v 1.7 2006/08/06 00:47:46 mcummings Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="A simple tree object"
SRC_URI="mirror://cpan/authors/id/S/ST/STEVAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~stevan/${P}/"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc ~amd64"

DEPEND=">=virtual/perl-Test-Simple-0.47
	>=dev-perl/Test-Exception-0.15
	dev-lang/perl"
RDEPEND="${DEPEND}"
IUSE=""

