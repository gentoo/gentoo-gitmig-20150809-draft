# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.23.ebuild,v 1.6 2011/12/18 16:23:06 armin76 Exp $

inherit perl-module

DESCRIPTION="Manipulate persons name"
SRC_URI="mirror://cpan/authors/id/K/KI/KIMRYAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kimryan"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc x86"

DEPEND="dev-perl/Parse-RecDescent
	dev-lang/perl"
IUSE=""
