# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.70-r1.ebuild,v 1.5 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/F/FI/FIMM/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

mydoc="TODO"

src_compile() {
	
	base_src_compile
	base_src_test
}
