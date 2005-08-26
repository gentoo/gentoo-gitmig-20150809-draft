# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV_XS/Text-CSV_XS-0.23-r1.ebuild,v 1.2 2005/08/26 00:24:16 agriffis Exp $

inherit perl-module

DESCRIPTION="comma-separated values manipulation routines"
SRC_URI="mirror://cpan/authors/id/J/JW/JWIED/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jwied/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
