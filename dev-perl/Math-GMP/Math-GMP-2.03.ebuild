# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-GMP/Math-GMP-2.03.ebuild,v 1.11 2006/07/04 12:33:09 ian Exp $

inherit perl-module

DESCRIPTION="High speed arbitrary size integer math"
SRC_URI="mirror://cpan/authors/id/C/CH/CHIPT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/C/CH/CHIPT/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 alpha ~ppc sparc amd64 ~mips"
IUSE=""

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"
