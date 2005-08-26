# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-Yapp/Parse-Yapp-1.05-r1.ebuild,v 1.14 2005/08/26 00:02:30 agriffis Exp $

inherit perl-module

MY_P="${P/_/}"

DESCRIPTION="Compiles yacc-like LALR grammars to generate Perl OO parser modules"
HOMEPAGE="http://cpan.org/modules/by-module/Parse/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/F/FD/FDESAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	perl-module_src_install

	insinto /usr/share/doc/${PF}/examples
	doins Calc.yp YappParse.yp
}
