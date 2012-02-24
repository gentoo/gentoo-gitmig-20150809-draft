# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.330.0.ebuild,v 1.2 2012/02/24 10:14:23 ago Exp $

EAPI=4

MODULE_AUTHOR=TWH
MODULE_VERSION=0.33
inherit perl-module

DESCRIPTION="Seamlessly enable SVG output from scripts written using GD"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/GD
	dev-perl/SVG"
RDEPEND="${DEPEND}"

SRC_TEST="do"
