# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Calc/Date-Calc-5.4.ebuild,v 1.6 2005/08/26 02:15:43 agriffis Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
HOMEPAGE="http://www.cpan.org/~stbey/${P}/"
SRC_URI="mirror://cpan/authors/id/STBEY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND=">=dev-perl/Bit-Vector-6.4
	>=dev-perl/Carp-Clan-5.3"

SRC_TEST="do"
export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
