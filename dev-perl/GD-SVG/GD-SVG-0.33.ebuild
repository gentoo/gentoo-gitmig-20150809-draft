# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.33.ebuild,v 1.1 2009/05/11 10:56:11 tove Exp $

EAPI=2

MODULE_AUTHOR=TWH
inherit perl-module

DESCRIPTION="Seamlessly enable SVG output from scripts written using GD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/GD
	dev-perl/SVG"
RDEPEND="${DEPEND}"

SRC_TEST="do"
