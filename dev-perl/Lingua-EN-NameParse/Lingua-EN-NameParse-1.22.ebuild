# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.22.ebuild,v 1.1 2005/11/26 07:16:31 chriswhite Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="mirror://cpan/authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KI/KIMRYAN/${P}.readme"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ppc ~x86"

DEPEND="dev-perl/Parse-RecDescent"
IUSE=""
