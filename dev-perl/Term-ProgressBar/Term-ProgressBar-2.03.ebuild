# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.03.ebuild,v 1.7 2004/07/14 20:35:24 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"
SRC_URI="http://search.cpan.org/CPAN/authors/id/F/FL/FLUFFY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/FLUFFY/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"
IUSE=""

DEPEND="dev-perl/Class-MethodMaker
		dev-perl/TermReadKey"
