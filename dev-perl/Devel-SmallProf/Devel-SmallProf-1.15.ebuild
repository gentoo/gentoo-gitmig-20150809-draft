# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-SmallProf/Devel-SmallProf-1.15.ebuild,v 1.3 2006/08/05 02:53:32 mcummings Exp $

inherit perl-module

DESCRIPTION="per-line Perl profiler"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SA/SALVA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
