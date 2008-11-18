# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Path-Class/Path-Class-0.16.ebuild,v 1.8 2008/11/18 15:23:03 tove Exp $

inherit perl-module

DESCRIPTION="Cross-platform path specification manipulation"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kwilliams/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~ia64 ppc sparc x86 ~ppc64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl
	>=virtual/perl-File-Spec-0.87
	virtual/perl-Test-Simple
	>=virtual/perl-Module-Build-0.28"
