# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.009.ebuild,v 1.6 2005/01/21 21:08:36 gustavoz Exp $

inherit perl-module

MY_P=Class-MakeMethods-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Automated method creation module for Perl"
SRC_URI="mirror://cpan/modules/by-module/Class/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Class/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"
IUSE=""

SRC_TEST="do"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
