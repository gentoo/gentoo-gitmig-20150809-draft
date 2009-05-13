# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVG-Graph/SVG-Graph-0.02.ebuild,v 1.3 2009/05/13 16:32:07 ken69267 Exp $

EAPI=2

MODULE_AUTHOR=ALLENDAY
inherit perl-module

DESCRIPTION="Visualize your data in Scalable Vector Graphics (SVG) format"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/Math-Derivative
	dev-perl/Math-Spline
	>=dev-perl/Statistics-Descriptive-2.6
	dev-perl/SVG
	>=dev-perl/Tree-DAG_Node-1.04"
RDEPEND="${DEPEND}"

SRC_TEST="do"
