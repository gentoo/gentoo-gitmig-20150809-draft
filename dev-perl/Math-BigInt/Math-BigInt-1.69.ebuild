# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt/Math-BigInt-1.69.ebuild,v 1.8 2004/10/19 07:49:59 absinthe Exp $

inherit perl-module

DESCRIPTION="Arbitrary size floating point math package"
SRC_URI="http://www.cpan.org/modules/by-authors/id/T/TE/TELS/math/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TE/TELS/math/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ~ppc sparc s390"
IUSE=""
