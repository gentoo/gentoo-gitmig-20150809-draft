# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-GMP/Math-GMP-2.04.ebuild,v 1.4 2005/05/01 18:09:22 slarti Exp $

inherit perl-module

DESCRIPTION="High speed arbitrary size integer math"
SRC_URI="mirror://cpan/authors/id/C/CH/CHIPT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chipt/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 alpha ~ppc sparc amd64 ~mips"
IUSE=""

DEPEND="dev-libs/gmp"
