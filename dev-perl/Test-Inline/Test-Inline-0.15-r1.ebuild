# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inline/Test-Inline-0.15-r1.ebuild,v 1.5 2003/06/21 21:36:37 drobbins Exp $

inherit perl-module

MY_P=Test-Inline-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Inline test suite support for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Test/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Inline"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Memoize
	dev-perl/Test-Simple"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
