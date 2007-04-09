# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-CUPS/Net-CUPS-0.50.ebuild,v 1.2 2007/04/09 15:37:11 mcummings Exp $

inherit perl-module

DESCRIPTION="CUPS C API Interface"
HOMEPAGE="http://search.cpan.org/~dhageman/"
SRC_URI="mirror://cpan/authors/id/D/DH/DHAGEMAN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND=">=net-print/cups-1.1.21
		dev-lang/perl
		test? ( virtual/perl-Test-Simple )"
