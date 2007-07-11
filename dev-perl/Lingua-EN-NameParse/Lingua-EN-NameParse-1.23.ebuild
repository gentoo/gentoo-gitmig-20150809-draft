# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.23.ebuild,v 1.5 2007/07/11 16:27:07 armin76 Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="mirror://cpan/authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kimryan"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc x86"

DEPEND="dev-perl/Parse-RecDescent
	dev-lang/perl"
IUSE=""
