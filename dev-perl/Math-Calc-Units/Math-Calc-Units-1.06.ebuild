# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Calc-Units/Math-Calc-Units-1.06.ebuild,v 1.1 2009/02/15 18:21:43 tove Exp $

MODULE_AUTHOR=SFINK
inherit perl-module

DESCRIPTION="Human-readable unit-aware calculator"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-Time-Local"
RDEPEND="${RDEPEND}"

SRC_TEST=do
