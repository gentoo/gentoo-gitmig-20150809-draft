# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-GMP/Math-GMP-2.03.ebuild,v 1.6 2004/06/25 00:45:18 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="High speed arbitrary size integer math"
SRC_URI="http://www.cpan.org/modules/by-authors/id/C/CH/CHIPT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/C/CH/CHIPT/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 alpha ~ppc sparc ~amd64 ~mips"

DEPEND="dev-libs/gmp"
