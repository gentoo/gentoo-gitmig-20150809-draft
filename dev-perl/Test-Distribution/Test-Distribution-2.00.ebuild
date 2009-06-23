# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Distribution/Test-Distribution-2.00.ebuild,v 1.1 2009/06/23 07:46:55 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="SRSHAH"

inherit perl-module

DESCRIPTION="No description available"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Pod-Coverage-0.20
	>=dev-perl/File-Find-Rule-0.30
	dev-perl/Test-Pod-Coverage
	>=dev-perl/Module-CoreList-2.17
	>=dev-perl/Test-Pod-1.26"
RDEPEND="${DEPEND}"
