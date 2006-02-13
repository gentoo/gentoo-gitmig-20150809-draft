# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Assert-More/Carp-Assert-More-1.12.ebuild,v 1.5 2006/02/13 10:45:51 mcummings Exp $

inherit perl-module

DESCRIPTION="convenience wrappers around Carp::Assert"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Scalar-List-Utils
		dev-perl/Carp-Assert
		dev-perl/Test-Exception"
