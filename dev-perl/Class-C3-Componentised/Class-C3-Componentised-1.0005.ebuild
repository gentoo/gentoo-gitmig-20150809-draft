# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3-Componentised/Class-C3-Componentised-1.0005.ebuild,v 1.1 2009/06/23 07:35:09 robbat2 Exp $

MODULE_AUTHOR="ASH"
EAPI=2

inherit perl-module

DESCRIPTION="Load mix-ins or components to your C3-based class"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Test-Exception
	dev-perl/Class-Inspector
	dev-perl/MRO-Compat
	>=dev-perl/Class-C3-0.21"
RDEPEND="${DEPEND}"
