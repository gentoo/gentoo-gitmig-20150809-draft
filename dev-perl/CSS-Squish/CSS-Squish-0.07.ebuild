# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CSS-Squish/CSS-Squish-0.07.ebuild,v 1.1 2008/03/07 14:52:56 hollow Exp $

inherit perl-module

DESCRIPTION="Compact many CSS files into one big file"
SRC_URI="mirror://cpan/authors/id/R/RU/RUZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/R/RU/RUZ/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="dev-perl/URI
	virtual/perl-File-Spec"
