# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.06-r1.ebuild,v 1.9 2005/04/02 21:35:29 hansmi Exp $

inherit perl-module

MY_PV=2.06-r1
MY_P=${PN}-${MY_PV}
DESCRIPTION="Perl module for Term-ProgressBar"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/FLUFFY/${MY_P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="dev-perl/Class-MethodMaker
		dev-perl/TermReadKey
		dev-perl/module-build"
