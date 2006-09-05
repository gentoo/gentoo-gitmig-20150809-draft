# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.22.ebuild,v 1.8 2006/09/05 13:38:55 mcummings Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="mirror://cpan/authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KI/KIMRYAN/${P}.readme"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ia64 ppc x86"

DEPEND="dev-perl/Parse-RecDescent
	dev-lang/perl"
RDEPEND="${DEPEND}"
IUSE=""

