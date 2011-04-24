# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.280.0.ebuild,v 1.2 2011/04/24 15:22:09 grobian Exp $

EAPI=3

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.993
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
