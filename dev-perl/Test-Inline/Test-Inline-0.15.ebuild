# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inline/Test-Inline-0.15.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $

inherit perl-module

MY_P=Test-Inline-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Inline test suite support for Perl"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Test/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Inline"

SLOT="0"

SLOT="0"
DEPEND="${DEPEND}
	dev-perl/Memoize"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
