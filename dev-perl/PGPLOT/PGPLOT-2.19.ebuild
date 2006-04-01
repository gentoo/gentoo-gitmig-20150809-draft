# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PGPLOT/PGPLOT-2.19.ebuild,v 1.2 2006/04/01 14:35:58 agriffis Exp $

inherit perl-module

DESCRIPTION="allow subroutines in the PGPLOT graphics library to be called from Perl."
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/K/KG/KGB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

# Tests require active X display
#SRC_TEST="do"

DEPEND="sci-libs/pgplot
		virtual/x11
		>=dev-perl/ExtUtils-F77-1.13"
