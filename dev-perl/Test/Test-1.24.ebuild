# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test/Test-1.24.ebuild,v 1.3 2003/06/21 21:36:37 drobbins Exp $

inherit perl-module

DESCRIPTION="Utilities for writing test scripts"
SRC_URI="http://www.cpan.org/modules/by-module/Test/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Test/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64"

DEPEND="dev-perl/Test-Harness"

