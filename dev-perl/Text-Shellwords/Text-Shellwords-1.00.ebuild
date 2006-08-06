# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Shellwords/Text-Shellwords-1.00.ebuild,v 1.12 2006/08/06 00:29:29 mcummings Exp $

IUSE=""

inherit perl-module

DESCRIPTION="Provides shellwords() routine which parses lines of text and returns a set of tokens using the same rules that the Unix shell does."

SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
