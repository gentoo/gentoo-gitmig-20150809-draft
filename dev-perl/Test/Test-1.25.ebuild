# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test/Test-1.25.ebuild,v 1.5 2005/04/03 01:37:37 mcummings Exp $

inherit perl-module

DESCRIPTION="Utilities for writing test scripts"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Test/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~alpha ~hppa ~mips ~ppc sparc ~ppc64"

SRC_TEST="do"

DEPEND="dev-perl/Test-Harness"

