# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.20.ebuild,v 1.2 2004/09/02 13:31:01 dholm Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KI/KIMRYAN/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-perl/Parse-RecDescent"
IUSE=""
