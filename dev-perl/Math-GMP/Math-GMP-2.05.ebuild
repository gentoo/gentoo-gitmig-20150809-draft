# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-GMP/Math-GMP-2.05.ebuild,v 1.1 2008/10/20 20:15:19 tove Exp $

MODULE_AUTHOR=TURNSTEP
inherit perl-module

DESCRIPTION="High speed arbitrary size integer math"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do

DEPEND="dev-libs/gmp
	dev-lang/perl"
