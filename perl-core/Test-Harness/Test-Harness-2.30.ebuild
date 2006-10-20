# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Harness/Test-Harness-2.30.ebuild,v 1.3 2006/10/20 20:41:42 mcummings Exp $

inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"
SRC_URI="http://www.cpan.org/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"

DEPEND="dev-lang/perl"

mydoc="rfc*.txt"

src_compile() {
	perl-module_src_compile
}
