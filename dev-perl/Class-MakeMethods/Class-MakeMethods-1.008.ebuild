# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.008.ebuild,v 1.2 2003/12/31 12:12:59 mcummings Exp $

inherit perl-module

MY_P=Class-MakeMethods-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Automated method creation module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Class/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Class/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
