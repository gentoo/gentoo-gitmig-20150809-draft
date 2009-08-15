# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Calc-Units/Math-Calc-Units-1.07.ebuild,v 1.1 2009/08/15 13:24:58 tove Exp $

EAPI=2

MODULE_AUTHOR=SFINK
inherit perl-module

DESCRIPTION="Human-readable unit-aware calculator"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-Time-Local"
RDEPEND="${DEPEND}"

SRC_TEST=do
