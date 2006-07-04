# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.20.ebuild,v 1.6 2006/07/04 11:38:54 ian Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="mirror://cpan/authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KI/KIMRYAN/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ppc"

DEPEND="dev-perl/Parse-RecDescent"
RDEPEND="${DEPEND}"
IUSE=""
