# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.24.ebuild,v 1.2 2010/11/18 11:08:02 maekke Exp $

EAPI=3

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.97
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
