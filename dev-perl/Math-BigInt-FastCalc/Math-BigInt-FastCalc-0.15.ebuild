# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.15.ebuild,v 1.6 2008/03/28 10:05:53 jer Exp $

MODULE_AUTHOR="TELS/math"
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 hppa ppc x86"
RDEPEND=">=perl-core/Math-BigInt-1.87"
DEPEND="${RDEPEND}"

SRC_TEST="do"
