# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SimpleUnit/Test-SimpleUnit-1.21.ebuild,v 1.3 2004/07/14 20:41:03 agriffis Exp $

inherit perl-module

DESCRIPTION="Simplified Perl unit-testing framework"
HOMEPAGE="http://search.cpan.org/~ged/${P}/"
SRC_URI="http://www.cpan.org/authors/id/G/GE/GED/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/ExtUtils-AutoInstall
		dev-perl/Data-Compare"
