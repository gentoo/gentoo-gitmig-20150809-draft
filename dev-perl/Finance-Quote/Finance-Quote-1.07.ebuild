# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: 

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Finance-Quote Module"
SRC_URI="http://www.cpan.org/modules/by-module/Finance/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Finance/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="${DEPEND}
		dev-perl/HTML-TableExtract"

RDEPEND="${DEPEND}"

mydoc="TODO"
