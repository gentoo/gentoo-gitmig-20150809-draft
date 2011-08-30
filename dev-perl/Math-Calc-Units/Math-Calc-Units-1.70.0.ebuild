# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Calc-Units/Math-Calc-Units-1.70.0.ebuild,v 1.1 2011/08/30 10:32:24 tove Exp $

EAPI=4

MODULE_AUTHOR=SFINK
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Human-readable unit-aware calculator"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-Time-Local"
RDEPEND="${DEPEND}"

SRC_TEST=do
