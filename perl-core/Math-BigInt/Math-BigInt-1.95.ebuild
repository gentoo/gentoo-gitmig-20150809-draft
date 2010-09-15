# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.95.ebuild,v 1.1 2010/09/15 09:07:28 tove Exp $

EAPI=3

MODULE_AUTHOR=FLORA
inherit perl-module eutils

DESCRIPTION="Arbitrary size floating point math package"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-Scalar-List-Utils-1.14"

PDEPEND=">=perl-core/bignum-0.22
	>=perl-core/Math-BigRat-0.22"

SRC_TEST="do"
