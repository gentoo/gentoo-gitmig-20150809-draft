# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Harness/Test-Harness-2.24.ebuild,v 1.3 2002/07/25 04:56:38 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Runs perl standard test scripts with statistics"
SRC_URI="http://www.cpan.org/authors/id/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

mydoc="rfc*.txt"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
