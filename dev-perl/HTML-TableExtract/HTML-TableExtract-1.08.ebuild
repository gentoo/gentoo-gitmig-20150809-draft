# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-1.08.ebuild,v 1.3 2003/02/13 11:09:45 vapier Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Table-Extract Module"
SRC_URI="http://www.cpan.org/modules/by-module/HTML/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="${DEPEND}"

mydoc="TODO"
