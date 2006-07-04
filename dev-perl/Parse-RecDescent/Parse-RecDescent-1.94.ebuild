# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.94.ebuild,v 1.19 2006/07/04 14:38:54 ian Exp $

inherit perl-module

DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"
HOMEPAGE="http://search.cpan.org/~dconway/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="perl-core/Text-Balanced"
RDEPEND="${DEPEND}"

src_install() {
	perl-module_src_install
	dohtml -r tutorial
}
