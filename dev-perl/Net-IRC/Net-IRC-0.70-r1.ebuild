# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.70-r1.ebuild,v 1.8 2002/08/01 03:21:52 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/F/FI/FIMM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc"

mydoc="TODO"

src_compile() {
	
	perl-module_src_compile
	perl-module_src_test
}
