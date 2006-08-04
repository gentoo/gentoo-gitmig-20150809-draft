# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.009.ebuild,v 1.13 2006/08/04 23:22:57 mcummings Exp $

inherit perl-module

DESCRIPTION="Automated method creation module for Perl"
SRC_URI="mirror://cpan/modules/by-module/Class/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Class/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
