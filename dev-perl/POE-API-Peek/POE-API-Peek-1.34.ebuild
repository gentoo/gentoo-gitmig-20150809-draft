# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-API-Peek/POE-API-Peek-1.34.ebuild,v 1.1 2009/06/23 07:45:04 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="SUNGO"

inherit perl-module

DESCRIPTION="Peek into the internals of a running POE env"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Test-Pod-Coverage
	dev-perl/Devel-Size
	dev-perl/Test-NoWarnings
	dev-perl/Test-Distribution
	dev-perl/POE"
RDEPEND="${DEPEND}"
