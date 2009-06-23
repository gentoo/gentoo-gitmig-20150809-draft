# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3-Componentised/Class-C3-Componentised-1.0005.ebuild,v 1.2 2009/06/23 13:38:23 tove Exp $

EAPI=2

MODULE_AUTHOR=ASH
inherit perl-module

DESCRIPTION="Load mix-ins or components to your C3-based class."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/MRO-Compat
	dev-perl/Class-Inspector
	>=dev-perl/Class-C3-0.20"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception )"

SRC_TEST=do
