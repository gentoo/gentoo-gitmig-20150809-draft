

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit perl-module

S=${WORKDIR}/Test-1.24
DESCRIPTION="Utilities for writing test scripts"
SRC_URI="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/Test-1.24.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="alpha arm hppa mips ppc sparc x86"

DEPEND="dev-perl/Test-Harness"

