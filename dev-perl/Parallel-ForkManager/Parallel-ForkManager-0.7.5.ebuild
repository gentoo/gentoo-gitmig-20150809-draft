# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parallel-ForkManager/Parallel-ForkManager-0.7.5.ebuild,v 1.11 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Parallel ForkManager module"
SRC_URI="mirror://cpan/authors/id/D/DL/DLUX/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dlux/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}

DEPEND="dev-lang/perl"
