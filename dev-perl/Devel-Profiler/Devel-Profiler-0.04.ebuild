# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Profiler/Devel-Profiler-0.04.ebuild,v 1.10 2006/07/10 15:16:50 agriffis Exp $

inherit perl-module

DESCRIPTION="a Perl profiler compatible with dprofpp"
HOMEPAGE="http://search.cpan.org/~samtregar/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
