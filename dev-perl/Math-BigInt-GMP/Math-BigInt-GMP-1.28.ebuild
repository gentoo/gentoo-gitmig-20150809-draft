# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt-GMP/Math-BigInt-GMP-1.28.ebuild,v 1.1 2010/09/18 19:51:37 tove Exp $

EAPI=3

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Use the GMP library for Math::BigInt routines"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=perl-core/Math-BigInt-1.90
		 >=dev-libs/gmp-4.0.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
