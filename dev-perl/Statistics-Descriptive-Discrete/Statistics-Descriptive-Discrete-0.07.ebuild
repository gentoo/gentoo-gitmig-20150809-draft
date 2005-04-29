# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive-Discrete/Statistics-Descriptive-Discrete-0.07.ebuild,v 1.5 2005/04/29 13:21:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Statistics-Descriptive-Discrete module"
SRC_URI="mirror://cpan/authors/id/R/RH/RHETTBULL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Statistics::Descriptive::Discrete"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"
IUSE=""

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}
