# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.09.ebuild,v 1.2 2005/08/26 00:19:44 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/FLUFFY/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Class-MethodMaker
		dev-perl/TermReadKey
		dev-perl/module-build"
