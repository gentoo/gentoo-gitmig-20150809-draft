# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt/Math-BigInt-1.73.ebuild,v 1.3 2005/01/22 00:15:00 kloeri Exp $

inherit perl-module

DESCRIPTION="Arbitrary size floating point math package"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/math/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TE/TELS/math/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 alpha ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-perl/Scalar-List-Utils-1.14"
