# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Simple/Test-Simple-0.47-r1.ebuild,v 1.9 2005/02/06 18:26:36 corsair Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
SRC_URI="http://www.cpan.org/authors/id/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ~mips"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
DEPEND=">=dev-lang/perl-5.8.0-r12
		>=dev-perl/Test-Harness-1.23"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
