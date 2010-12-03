# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-GD/Template-GD-2.66.ebuild,v 1.18 2010/12/03 02:26:13 xmw Exp $

EAPI=2

MODULE_AUTHOR=ABW
inherit perl-module

DESCRIPTION="GD plugin(s) for the Template Toolkit"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/GD
	dev-perl/GDTextUtil
	dev-perl/GDGraph
	dev-perl/GD-Graph3d
	>=dev-perl/Template-Toolkit-2.15-r1"
DEPEND="${RDEPEND}
	test? ( dev-perl/GD[png] )"

SRC_TEST="do"
