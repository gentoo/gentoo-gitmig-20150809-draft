# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Simple/Test-Simple-0.47-r1.ebuild,v 1.11 2005/05/25 14:52:24 mcummings Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
SRC_URI="http://www.cpan.org/authors/id/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sparc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12
	>=perl-core/Test-Harness-1.23"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
