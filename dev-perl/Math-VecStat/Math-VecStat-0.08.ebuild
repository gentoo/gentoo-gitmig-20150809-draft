# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-VecStat/Math-VecStat-0.08.ebuild,v 1.2 2005/07/18 18:03:29 gustavoz Exp $

inherit perl-module

DESCRIPTION="Some basic numeric stats on vectors"
SRC_URI="mirror://cpan/authors/id/A/AS/ASPINELLI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~aspinelli/Math-VecStat-0.08/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~sparc ~x86"
IUSE=""

SRC_TEST="do"
