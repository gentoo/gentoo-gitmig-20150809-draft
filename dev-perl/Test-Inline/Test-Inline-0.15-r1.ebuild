# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inline/Test-Inline-0.15-r1.ebuild,v 1.9 2004/10/16 23:57:23 rac Exp $

inherit perl-module

MY_P=Test-Inline-${PV}
DESCRIPTION="Inline test suite support for Perl"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Inline"
SRC_URI="http://www.cpan.org/modules/by-module/Test/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="dev-perl/Memoize
	dev-perl/Test-Simple"

S=${WORKDIR}/${MY_P}

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
