# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Override/Sub-Override-0.08.ebuild,v 1.9 2007/01/19 15:53:27 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for easily overriding subroutines"
HOMEPAGE="http://search.cpan.org/~ovid/"
SRC_URI="mirror://cpan/authors/id/O/OV/OVID/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86"

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Test-Exception-0.21
	dev-lang/perl"
