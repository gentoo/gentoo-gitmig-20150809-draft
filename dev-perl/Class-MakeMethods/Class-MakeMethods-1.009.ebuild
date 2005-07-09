# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.009.ebuild,v 1.10 2005/07/09 23:26:45 swegener Exp $

inherit perl-module

DESCRIPTION="Automated method creation module for Perl"
SRC_URI="mirror://cpan/modules/by-module/Class/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Class/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

SRC_TEST="do"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
