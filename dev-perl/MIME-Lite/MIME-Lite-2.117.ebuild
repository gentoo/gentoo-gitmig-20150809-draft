# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="low-calorie MIME generator"
http://search.cpan.org/CPAN/authors/id/E/ER/ERYQ
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ER/ERYQ/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/src/ERYQ/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
