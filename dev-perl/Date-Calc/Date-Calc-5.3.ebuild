# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Calc/Date-Calc-5.3.ebuild,v 1.9 2005/04/25 13:32:47 mcummings Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
HOMEPAGE="http://www.cpan.org/authors/id/STBEY/${P}.readme"
SRC_URI="mirror://cpan/authors/id/STBEY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha amd64 s390"
IUSE=""

DEPEND="dev-perl/Bit-Vector"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
