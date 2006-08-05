# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Profiler/Devel-Profiler-0.04.ebuild,v 1.11 2006/08/05 02:51:16 mcummings Exp $

inherit perl-module

DESCRIPTION="a Perl profiler compatible with dprofpp"
HOMEPAGE="http://search.cpan.org/~samtregar/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
