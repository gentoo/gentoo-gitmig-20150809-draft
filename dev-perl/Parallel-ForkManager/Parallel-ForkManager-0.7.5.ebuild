# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parallel-ForkManager/Parallel-ForkManager-0.7.5.ebuild,v 1.2 2004/06/25 00:52:46 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Parallel ForkManager module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DL/DLUX/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Parallel::ForkManager"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}
