# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WikiFormat/Text-WikiFormat-0.76.ebuild,v 1.10 2006/08/06 00:32:33 mcummings Exp $

inherit perl-module

DESCRIPTION="Translate Wiki formatted text into other formats"
SRC_URI="mirror://cpan/authors/id/C/CH/CHROMATIC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chromatic/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND="dev-perl/URI
	virtual/perl-Scalar-List-Utils
		>=dev-perl/module-build-0.28
	dev-lang/perl"
RDEPEND="${DEPEND}"
IUSE=""

SRC_TEST="do"


