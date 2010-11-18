# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.99.ebuild,v 1.2 2010/11/18 11:03:22 maekke Exp $

EAPI=3

MODULE_AUTHOR=FLORA
inherit perl-module eutils

DESCRIPTION="Arbitrary size floating point math package"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.14"
DEPEND="${RDEPEND}"

PDEPEND=">=virtual/perl-Math-BigInt-FastCalc-0.24
	>=perl-core/bignum-0.22
	>=perl-core/Math-BigRat-0.22"

SRC_TEST="do"
