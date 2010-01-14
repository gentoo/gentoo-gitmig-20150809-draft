# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SimpleUnit/Test-SimpleUnit-1.21.ebuild,v 1.14 2010/01/14 14:58:32 grobian Exp $

inherit perl-module

DESCRIPTION="Simplified Perl unit-testing framework"
HOMEPAGE="http://search.cpan.org/~ged/"
SRC_URI="mirror://cpan/authors/id/G/GE/GED/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/ExtUtils-AutoInstall
	dev-perl/Data-Compare
	dev-lang/perl"
