# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.80-r3.ebuild,v 1.10 2005/01/04 13:29:00 mcummings Exp $

inherit perl-module

DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dconway/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

src_install () {

	perl-module_src_install
	dohtml -r tutorial
}
