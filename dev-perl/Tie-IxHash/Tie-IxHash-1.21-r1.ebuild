# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-IxHash/Tie-IxHash-1.21-r1.ebuild,v 1.15 2006/08/06 00:34:26 mcummings Exp $

inherit perl-module

DESCRIPTION="ordered associative arrays for Perl"
HOMEPAGE="http://www.cpan.org/modules/by-module/Tie/${P}.readme"
SRC_URI="mirror://cpan/authors/id/G/GS/GSAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
