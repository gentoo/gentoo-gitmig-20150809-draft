# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Spline/Math-Spline-0.01.ebuild,v 1.3 2009/05/13 16:28:42 ken69267 Exp $

EAPI=2

MODULE_AUTHOR=JARW
inherit perl-module

DESCRIPTION="Cubic Spline Interpolation of data"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-perl/Math-Derivative"

# no tests
SRC_TEST="no"
PATCHES=( "${FILESDIR}"/${PV}-pod.diff )
