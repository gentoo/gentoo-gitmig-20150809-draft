# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.70-r1.ebuild,v 1.16 2003/09/06 22:37:58 msterret Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/F/FI/FIMM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}
