# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/self/self-0.32.ebuild,v 1.1 2009/06/23 07:48:45 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="GUGOD"

inherit perl-module

DESCRIPTION="provides '\$self' in OO code."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/B-Hooks-Parser-0.09
	dev-perl/Sub-Exporter
	>=dev-perl/Devel-Declare-0.005005
	>=dev-perl/B-OPCheck-0.27"
RDEPEND="${DEPEND}"
