# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aaron Blew <moath@oddbox.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.70-r1.ebuild,v 1.3 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl IRC module"
SRC_URI="http://www.cpan.org/authors/id/F/FI/FIMM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

mydoc="TODO"

src_compile() {
	
	base_src_compile
	base_src_test
}
