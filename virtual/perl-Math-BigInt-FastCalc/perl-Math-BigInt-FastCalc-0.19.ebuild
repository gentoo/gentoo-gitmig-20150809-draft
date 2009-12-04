# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Math-BigInt-FastCalc/perl-Math-BigInt-FastCalc-0.19.ebuild,v 1.5 2009/12/04 13:34:45 tove Exp $

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Math-BigInt-FastCalc-${PV} )"
