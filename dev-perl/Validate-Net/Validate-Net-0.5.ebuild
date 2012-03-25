# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.5.ebuild,v 1.16 2012/03/25 17:22:49 armin76 Exp $

inherit perl-module

DESCRIPTION="Format validation and more for Net:: related strings"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ~mips ~ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	dev-perl/Class-Default
	dev-perl/Class-Inspector
	dev-lang/perl"
