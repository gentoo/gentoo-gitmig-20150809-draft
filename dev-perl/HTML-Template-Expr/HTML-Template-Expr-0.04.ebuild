# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template-Expr/HTML-Template-Expr-0.04.ebuild,v 1.9 2005/05/25 15:09:04 mcummings Exp $

inherit perl-module

DESCRIPTION="HTML::Template extension adding expression support"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1 GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~amd64 sparc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/HTML-Template
		dev-perl/Parse-RecDescent
		dev-perl/Text-Balanced
		perl-core/Test-Simple"
