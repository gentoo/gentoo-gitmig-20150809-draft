# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Calc/Date-Calc-5.3.ebuild,v 1.4 2004/04/15 21:13:45 randy Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
HOMEPAGE="http://www.cpan.org/authors/id/STBEY/${P}.readme"
SRC_URI="http://www.cpan.org/authors/id/STBEY/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha amd64 s390"

DEPEND="dev-perl/Bit-Vector"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
