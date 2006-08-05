# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.74.ebuild,v 1.10 2006/08/05 14:19:54 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/J/JM/JMUHLICH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
