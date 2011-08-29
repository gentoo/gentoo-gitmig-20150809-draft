# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVG-Graph/SVG-Graph-0.20.0.ebuild,v 1.1 2011/08/29 09:33:59 tove Exp $

EAPI=4

MODULE_AUTHOR=ALLENDAY
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Visualize your data in Scalable Vector Graphics (SVG) format"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Math-Derivative
	dev-perl/Math-Spline
	>=dev-perl/Statistics-Descriptive-2.6
	dev-perl/SVG
	>=dev-perl/Tree-DAG_Node-1.04"
RDEPEND="${DEPEND}"

SRC_TEST="do"
