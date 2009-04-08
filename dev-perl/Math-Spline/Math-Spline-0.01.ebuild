# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Spline/Math-Spline-0.01.ebuild,v 1.1 2009/04/08 20:32:47 weaver Exp $

EAPI=2

MODULE_AUTHOR=JARW
inherit perl-module

DESCRIPTION="Cubic Spline Interpolation of data"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Math-Derivative"

SRC_TEST="do"
