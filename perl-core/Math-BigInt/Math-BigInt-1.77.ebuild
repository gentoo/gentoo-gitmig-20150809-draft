# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.77.ebuild,v 1.3 2006/01/13 22:44:00 mcummings Exp $

inherit perl-module

DESCRIPTION="Arbitrary size floating point math package"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TE/TELS/math/${P}.readme"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/math/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~s390 sparc x86"
IUSE=""

DEPEND=">=perl-core/Scalar-List-Utils-1.14"

SRC_TEST="do"
