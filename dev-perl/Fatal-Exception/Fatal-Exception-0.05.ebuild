# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Fatal-Exception/Fatal-Exception-0.05.ebuild,v 1.1 2009/06/23 07:40:53 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="DEXTER"

inherit perl-module

DESCRIPTION="Succeed or throw exception"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Exception-Warning
	>=dev-perl/Test-Unit-Lite-0.12
	dev-perl/Exception-Died
	dev-perl/Test-Assert
	>=dev-perl/Exception-Base-0.2201"
RDEPEND="${DEPEND}"
