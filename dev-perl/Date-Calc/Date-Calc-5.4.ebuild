# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Calc/Date-Calc-5.4.ebuild,v 1.3 2005/04/26 19:46:55 kloeri Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
HOMEPAGE="http://www.cpan.org/~stbey/${P}/"
SRC_URI="mirror://cpan/authors/id/STBEY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc ~ppc alpha ~amd64 ~s390"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Bit-Vector-6.4
		>=dev-perl/Carp-Clan-5.3"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
