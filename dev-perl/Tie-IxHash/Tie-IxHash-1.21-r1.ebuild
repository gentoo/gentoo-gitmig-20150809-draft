# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-IxHash/Tie-IxHash-1.21-r1.ebuild,v 1.16 2006/11/28 22:20:04 dev-zero Exp $

inherit perl-module

DESCRIPTION="ordered associative arrays for Perl"
HOMEPAGE="http://www.cpan.org/modules/by-module/Tie/${P}.readme"
SRC_URI="mirror://cpan/authors/id/G/GS/GSAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
