# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test/Test-1.24.ebuild,v 1.3 2006/07/05 20:01:29 ian Exp $

inherit perl-module

DESCRIPTION="Utilities for writing test scripts"
SRC_URI="http://www.cpan.org/modules/by-module/Test/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Test/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha hppa mips ppc sparc"

DEPEND="perl-core/Test-Harness"
RDEPEND="${DEPEND}"
