# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Simple/Test-Simple-0.47-r1.ebuild,v 1.2 2005/12/17 02:32:06 chriswhite Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
SRC_URI="http://www.cpan.org/authors/id/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sparc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
